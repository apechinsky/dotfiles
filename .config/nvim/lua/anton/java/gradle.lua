--
-- Gradle specific functions
--
local M = {}

local utils = require('anton.utils')
local java_utils = require('anton.java.utils')

function M.get_test_runner(tests)
    return 'gradlew -i test ' ..
        utils.format_if_present(' --tests=%s ', tests)
end

function M.run_java_test_method()
    local method = java_utils.get_current_method_full()
    vim.cmd('wa | split | terminal ' .. M.get_test_runner(method))
end

function M.run_java_test_class()
    local class = java_utils.get_current_class_full()
    vim.cmd('wa | split | terminal ' .. M.get_test_runner(class))
end

function M.get_spring_boot_runner(profile)
    return 'gradlew bootRun ' ..
        utils.format_if_present("-Dspring.profiles.active=%s", profile)
end

function M.run_spring_boot()
    vim.cmd('wa | split | terminal ' .. M.get_spring_boot_runner())
end

return M
