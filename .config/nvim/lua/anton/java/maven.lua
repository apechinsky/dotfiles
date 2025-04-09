--
-- Maven class.
-- Encapsulates Maven specific methods.
--

local utils = require('anton.core.utils')
local java_utils = require('anton.java.utils')
local Path = require('plenary.path')

local mvnw = 'mvnw'

local Maven = {}

function Maven:new(root_dir)
    self.__index = self

    local instance = setmetatable({}, self)
    instance.root_dir = root_dir
    return instance
end

function Maven:get_root_dir()
    return self.root_dir
end

function Maven:get_name()
    local result = vim.trim(
        vim.fn.system('grep -oPm1 "(?<=<groupId>)[^<]+" ' .. self.root_dir .. '/pom.xml '))
    return result
end

-- Returns a list of maven modules from pom.xml
function Maven:get_modules()
    local names = vim.fn.system(
        'grep -oP "(?<=<module>)[^<]+" ' .. self.root_dir .. '/pom.xml ')
    return vim.fn.split(names, '\n', false)
end

function Maven:dump()
    print("Gradle project [" ..
        "name: '" .. (self:get_name() or "nil") .. "'" ..
        ", root: " .. (self:get_root_dir() or "nil") ..
        -- ", modules: [ TBD ]" ..
        ", modules: [" .. table.concat(self:get_modules(), ', ') .. "]" ..
        "]")
end
local M = {}

--
-- Find Maven project and return Maven class instance
--
function M.find(start_file)
    local root_dir = utils.find_any({ mvnw }, start_file)
    return root_dir and Maven:new(root_dir) or nil
end

return M
