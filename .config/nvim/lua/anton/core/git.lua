--
-- Git functions
--
-- * Open current file in git web ui.
--   To enable this feature you should specify webui root URL in 'webui_git_property'
--   git configuration property.

local utils = require('anton.core.utils')
local Path = require('plenary.path')

local M = {}

-- Git configuration property containing base web URL
local webui_git_property = 'remote.origin.webui'

-- Git configuration property containing line fragment format (default: L%s)
local webui_lineformat_git_property = 'remote.origin.webuilineformat'

--
-- Find .git repository root
--
function M.find_git_root()
    return utils.find_any({ '.git' }, utils.get_current_file())
end

--
-- Returns config property value from local git configuration
--
-- @param property name of config property
-- @return property value or nil default value (nil)
--
function M.get_config(property, default)
    -- will fail if PWD is not in git repo!!!
    local webui = vim.fn.system("git config " .. property)

    if webui ~= nil and webui ~= '' then
        webui = webui:gsub("%s+", "")
    else
        webui = default
    end

    return webui
end

---
--- Trim string.
---
--- @param str string to trim.
--- @return string without leading and trailing whitespaces.
---
function M.trim(str)
    return str:gsub("%s+$", ""):gsub("^%s+", "")
end

---
--- Return current branch name
---
function M.get_current_branch()
    return M.trim(vim.fn.system("git branch --show-current"))
end

--
-- Obtain Git WebUI root URL from git config (remote.origin.webui)
--
function M.get_config_webui_root()
    return M.get_config(webui_git_property)
end

--
-- Detect Git WebUI root from remote URL
--
-- Extracts host  and path from remote URL and constructs WebUI URL.
-- URL is constructed as 'https://<host>/<path>/blob/<branch>'
--
-- @return WebUI root URL
--
function M.detect_webui_root()
    local gitUrl = M.get_config('remote.origin.url')

    local result = nil

    -- TODO: move URL parsing to separate class
    if gitUrl:match("^git@") then
        local _,_,host,path = gitUrl:find("git@(.+):(.+).git")
        result = string.format("https://%s/%s/blob/%s",
            host, path, M.get_current_branch())
    elseif gitUrl:match("^https:") then
        local _,_,host,path = gitUrl:find("https://(.+)/(.+).git")
        result = string.format("https://%s/%s/blob/%s",
            host, path, M.get_current_branch())
    end

    return result
end

--
-- Returns line fragment format.
--
-- Format is defined with 'remote.origin.webuilineformat' git config property.
--
-- github/gitlab/bitbucket use different format for line fragment
-- github #L25
-- gitlab #L25
-- bitbucket #25
--
-- @return value of 'remote.origin.webuilineformat' git config property or 
-- 'L%s' if not specified.
--
function M.git_webui_lineformat()
    return M.get_config(webui_lineformat_git_property, "L%d")
end

--
-- Return git WebUI of current file.
--
-- Returns git_webui_root if no current file.
--
function M.git_webui_current()
    local webui_root = M.get_config_webui_root() or M.detect_webui_root()
    if webui_root == nil or webui_root == '' then
        return nil
    end

    local current_file_path = Path:new(utils.get_current_file())
    local current_file_relative = current_file_path:make_relative(M.find_git_root())

    local current_file_url = utils.child(webui_root, current_file_relative)
    local current_file_line = vim.api.nvim_win_get_cursor(0)[1]

    local line_fragment = string.format(M.git_webui_lineformat(), current_file_line)

    return current_file_url .. '#' .. line_fragment
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
