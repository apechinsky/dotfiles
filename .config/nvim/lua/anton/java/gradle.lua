--
-- Gradle class.
-- Encapsulates Gradle specific methods.
--

local utils = require('anton.utils')
local java_utils = require('anton.java.utils')

local gradlew = 'gradlew'
local csbuild = 'csbuild'

local Gradle = {}

function Gradle:new(root_dir)
    self.__index = self

    local instance = setmetatable({}, self)
    instance.root_dir = root_dir
    return instance
end

function Gradle:get_root_dir()
    return self.root_dir
end

function Gradle:get_name()
    return utils.get_property(self:get_settings_file(), 'rootProject.name')
end

function Gradle:get_settings_file()
    return utils.child(self.root_dir, 'settings.gradle')
end

function Gradle:get_modules()
    local modules = {}

    for line in io.lines(self:get_settings_file()) do
        for module in line:gmatch("include%s*[\'\"]([%w%-]*)[\'\"]%s*") do
            table.insert(modules, module)
        end
    end

    return modules
end

function Gradle:is_multimodule()
    return #self:get_modules() > 0
end

function Gradle:relative(file)
    return utils.child(self.root_dir, file)
end

function Gradle:file(file)
    return utils.child(self.root_dir, file)
end

function Gradle:fileIfExists(file)
    local rootFile = self:file(file)
    return vim.fn.filereadable(rootFile) ~= 0 and rootFile or nil
end

function Gradle:csbuild()
    return self:fileIfExists(csbuild)
end

function Gradle:gradlew()
    return self:fileIfExists(gradlew)
end

function Gradle:executable()
    return self:csbuild() or self:gradlew()
end

function Gradle:dump()
    print("Gradle [" ..
        "name: " .. self:get_name() ..
        ", root: " .. self:get_root_dir() ..
        ", modules: [" .. table.concat(self:get_modules(), ', ') .. "]" ..
        "]")
end

function Gradle:get_run_command()
    return self:executable() .. ' --project-dir ' .. self.root_dir
end

function Gradle:get_module(file)
    local Path = require('plenary.path')
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

function Gradle:get_test_runner(module, test_filter)
    return self:get_run_command() ..
        " -i " ..
        utils.format_if_present(':%s:', module) ..
        "test " ..
        utils.format_if_present(' --tests %s ', test_filter)
end

function Gradle:run_java_test_method()
    local module = self:get_module(utils.get_current_file())
    local method = java_utils.get_current_method_full()
    if method then
        vim.cmd('w | split | terminal ' .. self:get_test_runner(module, method))
    else
        print("Can not run test method. Not within a method.")
    end
end

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
