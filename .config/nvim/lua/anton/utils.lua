--
-- Collection of general purpose utilities.
--

local M = {}

--
-- Asserts value is not nil and not empty
--
function M.assertNotEmpty(value, message)
    assert(value ~= nil and value ~= '', message)
end

--
-- Formats given value with the specified pattern.
-- Returns empty string if value is nil.
--
function M.format_if_present(pattern, value)
    return value and string.format(pattern, value) or ""
end

--
-- return value from "key='value'" expression
--
function M.getValue(keyValue)
    for k, v in string.gmatch(keyValue, "(%w+)%s*=%s*[\'\"](%w+)[\'\"]%s*") do
        if k ~= nil then
            return v
        end
    end
end

--
-- Returns value of property with specified key from given file.
--
function M.getProperty(file, key)
    for line in io.lines(file) do
        local s, e = string.find(line, key)
        if s ~= nil then
            return M.getValue(line)
        end
    end
end

function M.trimRight(path, char)
    M.assertNotEmpty(char, "Trim char must not be nil or empty")

    local result = path
    while string.sub(result, #result, #result) == char do
        result = string.sub(result, 1, #result - 1)
    end
    return result
end

function M.trimLeft(path, char)
    M.assertNotEmpty(char, "Trim char must not be nil or empty")

    local result = path
    while string.sub(result, 1, 1) == char do
        result = string.sub(result, 2, #result)
    end
    return result
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
--
-- Returns new instance of bufopts with specified 'desc'
-- 
function M.bufopts(bufopts, desc)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    return {
        noremap = bufopts.noremap,
        silent = bufopts.silent,
        buffer = bufopts.buffer,
        desc = desc
    }
end

return M
