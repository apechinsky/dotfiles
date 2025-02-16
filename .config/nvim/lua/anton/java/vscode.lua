--
-- VsCode Extension class
--

local M = {}
local utils = require('anton.core.utils')

--
-- Constructor
--
-- @param root_dir extension root directory
-- @param package_json_dir package.json directory relative to root_dir
--  Some extensions have package.json in the root directory, some in the 'extension' directory.
--
function M:new(root_dir, package_json_dir)
    self.__index = self

    local instance = setmetatable({}, self)
    instance.root_dir = root_dir
    instance.package_json_dir = utils.child(root_dir, package_json_dir)
    instance.package_json_file = utils.child(instance.package_json_dir, 'package.json')

    assert(vim.fn.filereadable(instance.package_json_file) == 1,
        "Can not create Vscode extension. " ..
        "File '" .. instance.package_json_file .. "' not found.")

    return instance
end

--
-- Returns package.json as a table
--
function M:package_json()
    return vim.json.decode(utils.load(self.package_json_file))
end

--
-- Returns list of extension bundles
--
-- @return table containing absolute paths to extension bundles
--
function M:bundles()
    local package_json_extensions = self:package_json().contributes.javaExtensions

    return utils.transform(package_json_extensions, function (item)
        return utils.child(self.package_json_dir, item)
    end)
end


return M
