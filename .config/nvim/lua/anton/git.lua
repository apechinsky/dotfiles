--
-- Git functions
--
-- * Open current file in git web ui.
--   To enable this feature you should specify webui root URL in 'webui_git_property'
--   git configuration property.

local utils = require('anton.utils')
local Path = require('plenary.path')

local M = {}

-- Git configuration property containing
local webui_git_property = 'remote.origin.webui'

--
-- Find .git repository root
--
function M.find_git_root()
    return utils.find_any({ '.git' }, utils.get_current_file())
end

--
-- Obtain Git WebUI root URL
--
function M.git_webui_root()
    local webui = vim.fn.system("git config " .. webui_git_property)

    if webui ~= nil then
        webui = webui:gsub("%s+", "")
    end

    return webui
end

--
-- Return git WebUI of current file.
-- Returns git_webui_root if no current file.
--
function M.git_webui_current()
    local webui_root = M.git_webui_root()
    if webui_root == nil or webui_root == '' then
        return nil
    end
    local current_file_path = Path:new(utils.get_current_file())
    local current_file_relative = current_file_path:make_relative(M.find_git_root())
    return utils.child(webui_root, 'browse/' .. current_file_relative)
end

--
-- Open git WebUI of current file in current web browser.
--
function M.open_git_webui_current()
    local current_file_webui = M.git_webui_current()
    if not current_file_webui then
        print("Can not open git web ui. Check '" .. webui_git_property .. "' git config option.")
        return
    end
    vim.fn.system("xdg-open " .. current_file_webui)
end

return M
