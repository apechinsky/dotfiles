-- XDG file structure object
-- Provides methods to obtain standard XDG dirs and subdirs
-- Methods are independent of trailing/leading slash presence.

local M = {}

local utils = require('anton.utils')

function M.config(sub)
    return utils.subpath(vim.fn.stdpath('config'), sub)
end

function M.data(sub)
    return utils.subpath(vim.fn.stdpath('data'), sub)
end

function M.cache(sub)
    return utils.subpath(vim.fn.stdpath('cache'), sub)
end

function M.tools(sub)
    return utils.subpath(M.config('tools'), sub)
end

return M
