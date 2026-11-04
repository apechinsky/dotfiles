--
-- Gradle class.
-- Encapsulates Gradle specific methods.
--

local utils = require('anton.core.utils')
local java_utils = require('anton.java.utils')
local kotlin_utils = require('anton.kotlin.utils')
local Path = require('plenary.path')

local gradlew = 'gradlew'
local csbuild = 'csbuild'

local Gradle = {}


--
-- Constructor
--
-- @param root_dir gradle project root directory
-- @throw error if settings.gradle is not found in root_dir
--
function Gradle:new(root_dir)
    self.__index = self

    local instance = setmetatable({}, self)
    instance.root_dir = root_dir

    instance.settings_file = instance:fileIfExists('settings.gradle')
        or instance:fileIfExists('settings.gradle.kts')

    assert(instance.settings_file,
        "Settings file not found in root_dir: '" .. root_dir .. "'")

    instance.name = utils.get_property(instance.settings_file, 'rootProject.name')

    if instance.name == nil then
        -- Try to infer project name from root dir name
        instance.name = Path:new(root_dir):make_relative(vim.loop.os_homedir())
        instance.name = instance.name:gsub(Path._sep, '_')
    end

    assert(instance.name, "Can not obtain project name from " .. instance.settings_file)

    return instance
end

-- Returns root dir that was passed to constructor
function Gradle:get_root_dir()
    return self.root_dir
end

-- Returns gradle project name from settings.gradle
function Gradle:get_name()
    return self.name
end

-- Returns settings.gradle file
function Gradle:get_settings_file()
    return self.settings_file
end

-- Returns a list of gradle modules (settings.gradle based)
function Gradle:get_modules()
    local modules = {}

    for line in io.lines(self:get_settings_file()) do
        for module in line:gmatch("include%s*[\'\"]([%w%-]*)[\'\"]%s*") do
            table.insert(modules, module)
        end

        -- Kotlin DSL: include("a", "b", ":c")
        for arguments in line:gmatch("include%s*%((.-)%)") do
            for module in arguments:gmatch("[\'\"]:?([^\'\":]+)[\'\"]") do
                table.insert(modules, module)
            end
        end
    end

    return modules
end

-- Tests if gradle projects is multimodule
function Gradle:is_multimodule()
    return #self:get_modules() > 0
end

-- Returns absolute file name from project relative file name
--
-- @param file an arbitrary file name
function Gradle:relative(file)
    return utils.child(self.root_dir, file)
end

-- Returns absolute file name from project relative file name
-- The same as #relative(file)
function Gradle:file(file)
    return utils.child(self.root_dir, file)
end

-- Returns absolute file name or nil if file does not exist
function Gradle:fileIfExists(file)
    local rootFile = self:file(file)
    return vim.fn.filereadable(rootFile) ~= 0 and rootFile or nil
end

-- Returns 'csbuild' file
function Gradle:csbuild()
    return self:fileIfExists(csbuild)
end

-- Returns 'gradlew' file
function Gradle:gradlew()
    return self:fileIfExists(gradlew)
end

-- Returns project executable script 'csbuild' or 'gradlew'
function Gradle:executable()
    return self:csbuild() or self:gradlew()
end

function Gradle:dump()
    print("Gradle project [" ..
        "name: " .. (self:get_name() or "nil") ..
        ", root: " .. (self:get_root_dir() or "nil") ..
        ", modules: [" .. table.concat(self:get_modules(), ', ') .. "]" ..
        "]")
end

-- Returns working directory independent gradle run command.
function Gradle:get_run_command()
    return self:executable() .. ' --project-dir ' .. self.root_dir
end

-- Get module name of specified file
--
-- @param absolute file name
-- @return module name
function Gradle:get_module(file)
    local path = Path:new(file)

    local relative = path:make_relative(self:get_root_dir())

    local index, _ = string.find(relative, path._sep)

    if index ~= nil then
        local module_candidate = relative:sub(1, index - 1)

        for _, module in ipairs(self:get_modules()) do
            if module == module_candidate then
                return module
            end
        end
    end
end

function Gradle:is_test_class(class)
    return class:match('Test$') ~= nil
end

function Gradle:get_test_class(class)
    assert(self:is_test_class(class), 'Class ' .. class .. ' is a test class!')
    return class .. 'Test'
end

function Gradle:get_tested_class(class)
    assert(not self:is_test_class(class), 'Class ' .. class .. ' is not a test class!')
    return class:sub(1, #class - #('Test'))
end

-- Work in progress: make a method to switch between class and it's test class
-- function Gradle:toggle_test_class()
--     local current_file = require('anton.core.utils').get_current_file()
--     local current_class = utils.get_current_class_full()
--
--     local next_class = self:is_test_class(class)
--         and self:get_tested_class(class)
--         or self:get_test_class(class)
--
--     local next_class_file = self:get_class_file(next_class)
--     if not files.exists(next_class_file) then
--         self:create_test_class(next_class_file)
--         
--     end
-- end
--
-- function Gradle:goto_class(class)
--     
-- end



-- Returns gradle run command for specified module and filter.
--
-- @param module name
-- @test_filter gradle test run filter
--
function Gradle:get_test_runner(module, test_filter)
    return self:get_run_command() ..
        " -i " ..
        utils.format_if_present(':%s:', module) ..
        "test " ..
        -- the filter is quoted: it may contain '$' (nested classes) or spaces (`backtick` names)
        utils.format_if_present('--rerun-tasks --tests %s', test_filter and vim.fn.shellescape(test_filter))
end

--
-- Returns gradle run command for current java test method.
--
function Gradle:run_java_test_method()
    local module = self:get_module(utils.get_current_file())
    local method = java_utils.get_current_method_full()
    if method then
        vim.cmd('w | split | terminal ' .. self:get_test_runner(module, method))
    else
        print("Can not run test method. Not within a method.")
    end
end

--
-- Returns gradle run command for current java test class.
--
function Gradle:run_java_test_class()
    local module = self:get_module(utils.get_current_file())
    local class = java_utils.get_current_class_full()
    if class then
        vim.cmd('w | split | terminal ' .. self:get_test_runner(module, class))
    else
        print("Can not run test class. Not within a class.")
    end
end

--
-- Runs gradle tests of the current Kotlin file with the specified filter
-- in the terminal split.
--
-- @param filter gradle test filter or nil to run all tests of the module
-- @param what description of the target for the error message
--
function Gradle:run_kotlin_tests(filter, what)
    if what and not filter then
        print("Can not run " .. what .. ".")
        return
    end

    local module = self:get_module(utils.get_current_file())
    -- ':terminal' expands '%' and '#' (current/alternate file name): escape them
    local command = self:get_test_runner(module, filter):gsub('[%%#]', '\\%0')
    vim.cmd('w | split | terminal ' .. command)
end

--
-- Returns gradle run command for current kotlin test method.
--
function Gradle:run_kotlin_test_method()
    self:run_kotlin_tests(kotlin_utils.get_current_method_full(),
        "test method. Not within a method of a class")
end

--
-- Returns gradle run command for current kotlin test class.
--
function Gradle:run_kotlin_test_class()
    self:run_kotlin_tests(kotlin_utils.get_current_class_full(),
        "test class. Not within a class")
end

--
-- Runs all tests of the module of the current Kotlin file.
--
function Gradle:run_kotlin_test_module()
    self:run_kotlin_tests(nil, nil)
end

function Gradle:run_check()
    local old_mp = vim.opt_local.makeprg
    local old_ef = vim.opt_local.errorformat

    vim.opt_local.makeprg = self:get_run_command() .. ' check'
    vim.opt_local.errorformat = table.concat({
        -- [ant:checkstyle] [ERROR] /path/File.java:263:8: message [CheckName]
        [[%E%*[^\ ]\ %*[^\ ]\ %f:%l%m]],
        -- File.java:28: error: message
        [[%E%f:%l:\ error:\ %m]],
        -- File.java:28: warning: message
        [[%W%f:%l:\ warning:\ %m]],
        -- File.java:28: note: message
        [[%I%f:%l:\ note:\ %m]],
        -- File.kt:28:10: error: message
        [[%E%f:%l:%c:\ error:\ %m]],
        -- File.kt:28:10: warning: message
        [[%W%f:%l:%c:\ warning:\ %m]],
        -- ignore everything else
        [[%-G%.%#]],
    }, ',')

    vim.cmd('silent make!')

    vim.opt_local.makeprg = old_mp
    vim.opt_local.errorformat = old_ef

    vim.cmd('copen')
end

function Gradle:get_spring_boot_runner(profile)
    return self:get_run_command() ..
        ' bootRun ' ..
        utils.format_if_present("-Dspring.profiles.active=%s", profile)
end

function Gradle:run_spring_boot()
    vim.cmd('w | split | terminal ' .. self:get_spring_boot_runner())
end

local M = {}

--
-- Find gradle project and return Gradle class instance
--
-- @param a file from which to find the Gradle root dir
--      ('gradlew' or 'settings.gradle' files)
-- @return an instance of Gradle class or nil if the root was not found
--
function M.find(start_file)
    local root_dir = utils.find_any({ gradlew, 'settings.gradle' }, start_file)
    return root_dir and Gradle:new(root_dir) or nil
end

return M
