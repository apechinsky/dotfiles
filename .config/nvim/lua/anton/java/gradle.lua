--
-- Gradle class.
-- Encapsulates Gradle specific methods.
--

local utils = require('anton.core.utils')
local java_utils = require('anton.java.utils')
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

    instance.settings_file = utils.child(instance.root_dir, 'settings.gradle')

    instance.name = utils.get_property(instance.settings_file, 'rootProject.name')
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
        utils.format_if_present(' --tests %s', test_filter)
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
function M.find(start_file)
    local root_dir = utils.find_any({ gradlew }, start_file)
    return root_dir and Gradle:new(root_dir) or nil
end

return M
