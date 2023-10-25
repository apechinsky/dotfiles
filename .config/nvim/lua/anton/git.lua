local utils = require('anton.utils')
local Path = require('plenary.path')

local M = {}

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
    local webui = vim.fn.system("git config remote.origin.webui")

    if webui ~= nil then
        webui = webui:gsub("%s+", "")
    end

    return webui
end

--
-- Obtain Git WebUI of current file.
-- Returns git_webui_root if no current file.
--
function M.git_webui_current()
    local current_file_path = Path:new(utils.get_current_file())
    local current_file_relative = current_file_path:make_relative(M.find_git_root())
    return utils.child(M.git_webui_root(), 'browse/' .. current_file_relative)
end

--
-- Obtain Git WebUI of current file.
-- Returns git_webui_root if no current file.
--
function M.open_git_webui_current()
    vim.fn.system("xdg-open " .. M.git_webui_current())
end

return M
