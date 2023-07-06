
local utils = require('anton.utils')

local Project = {}

function Project:new(root_dir)
    self.__index = self

    local instance = setmetatable({}, self)
    instance.root_dir = root_dir
    return instance
end

function Project:get_root_dir()
    return self.root_dir
end

function Project:get_name()
    return utils.get_dir_name(self.root_dir)
end

function Project:dump()
    print("Single file project [" ..
        "name: " .. (self:get_name() or "nil") ..
        ", root: " .. (self:get_root_dir() or "nil") ..
        "]")
end

local M = {}

function M.get(start_file)
    return Project:new(utils.get_dir(start_file))
end

return M
