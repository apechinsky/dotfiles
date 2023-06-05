-- XDG file structure object
-- Provides methods to obtain standard XDG dirs and subdirs
-- Methods are independent of trailing/leading slash presence.

local M = {}

function M.trimRight(path, char)
    return string.sub(path, #path, #path) == char
        and string.sub(path, 1, #path - 1)
        or path
end

function M.trimLeft(path, char)
    return string.sub(path, 1, 1) == char
        and string.sub(path, 2, #path)
        or path
end

function M.trimRightSlash(path)
    return M.trimRight(path, '/')
end

function M.trimLeftSlash(path)
    return M.trimLeft(path, '/')
end

function M.subpath(path, sub)
    local result = path 
    if sub then
        result = M.trimRightSlash(result) .. '/' .. M.trimLeftSlash(sub)
    end
    return result
end

function M.config(sub)
    return M.subpath(vim.fn.stdpath('config'), sub)
end

function M.data(sub)
    return M.subpath(vim.fn.stdpath('data'), sub)
end

function M.cache(sub)
    return M.subpath(vim.fn.stdpath('cache'), sub)
end

function M.tools(sub)
    return M.subpath(M.config('tools'), sub)
end

return M
