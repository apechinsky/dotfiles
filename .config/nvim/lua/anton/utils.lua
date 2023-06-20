--
-- Collection of general purpose utilities.
--

local M = {}

--
-- Asserts value is not nil and not empty
--
function M.assert_not_empty(value, message)
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
function M.get_value(keyValue)
    for k, v in string.gmatch(keyValue, "(%w+)%s*=%s*[\'\"](%w+)[\'\"]%s*") do
        if k ~= nil then
            return v
        end
    end
end

--
-- Returns value of property with specified key from given file.
--
function M.get_property(file, key)
    for line in io.lines(file) do
        local s, e = string.find(line, key)
        if s ~= nil then
            return M.get_value(line)
        end
    end
end

function M.trim_right(path, char)
    M.assert_not_empty(path, "Trim path must not be nil or empty")
    M.assert_not_empty(char, "Trim char must not be nil or empty")

    local result = path
    while string.sub(result, #result, #result) == char do
        result = string.sub(result, 1, #result - 1)
    end
    return result
end

function M.trim_left(path, char)
    M.assert_not_empty(char, "Trim char must not be nil or empty")

    local result = path
    while string.sub(result, 1, 1) == char do
        result = string.sub(result, 2, #result)
    end
    return result
end

function M.trim_right_slash(path)
    return M.trim_right(path, '/')
end

function M.trim_left_slash(path)
    return M.trim_left(path, '/')
end

-- function M.child(path, sub)
--     local result = path
--     if sub then
--         result = M.trim_right_slash(result) .. '/' .. M.trim_left_slash(sub)
--     end
--     return result
-- end

--
-- Deprecated. Use child(path, sub)
function M.child(path, sub)
    local result = path
    if sub then
        result = M.trim_right_slash(result) .. '/' .. M.trim_left_slash(sub)
    end
    return result
end

function M.get_current_file()
    return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

function M.get_dir(file)
    return vim.fn.fnamemodify(file, ':p:h')
end

function M.get_dir_name(dir)
    return vim.fn.fnamemodify(dir, ':t')
end

--
-- Find any of specified files starting from bufname or current 
-- buffer file and up to the FS root.
--
-- @param markers list of file names to find
-- @param bufname file name. If not specified, current buffer file is used
--
function M.find_any(markers, bufname)
    bufname = bufname or M.get_current_file()
    -- print("find_any(" .. bufname .. ")")

    local dirname = M.get_dir(bufname)

    local getparent = function(p)
        return vim.fn.fnamemodify(p, ':h')
    end

    while getparent(dirname) ~= dirname do
        for _, marker in ipairs(markers) do
            -- print(dirname .. "/" .. marker)
            if vim.fn.filereadable(dirname .. "/" .. marker) ~= 0 then
                return dirname
            end
        end
        dirname = getparent(dirname)
    end
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
