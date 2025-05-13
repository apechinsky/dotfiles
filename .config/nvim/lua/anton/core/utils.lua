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
    for k, v in string.gmatch(keyValue, "(%w+)%s*=%s*[\'\"](.+)[\'\"]%s*") do
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
        local s, _ = string.find(line, key)
        if s ~= nil then
            return M.get_value(line)
        end
    end
end

--
-- Remove trailing 'char' from 'str'
--
-- @param str string to trim (non-nil)
-- @param char character to remove (non empty and not nil)
-- @return trimmed string
-- @throws error if 'str' is nil or 'char' is nil or empty
--
function M.trim_right(str, char)
    assert(str ~= nil, "Argument 'str' must not be nil")
    M.assert_not_empty(char, "Argument 'char' must not be nil or empty")

    if str == '' then
        return str
    end

    local result = str
    while string.sub(result, #result, #result) == char do
        result = string.sub(result, 1, #result - 1)
    end
    return result
end

--
-- Remove leading 'char' from 'str'
--
-- @param str string to trim (non-nil)
-- @param char character to remove (non empty and not nil)
-- @return trimmed string
-- @throws error if 'str' is nil or 'char' is nil or empty
function M.trim_left(str, char)
    assert(str ~= nil, "Argument 'str' must not be nil")
    M.assert_not_empty(char, "Argument 'char' must not be nil or empty")

    if str == '' then
        return str
    end

    local result = str
    while string.sub(result, 1, 1) == char do
        result = string.sub(result, 2, #result)
    end
    return result
end

--
-- Remove trailing and leading 'char' from 'str'.
--
-- @param str string to trim (non-nil)
-- @param char character to remove (non empty and not nil)
-- @return trimmed string
-- @throws error if 'str' is nil or 'char' is nil or empty
--
function M.trim(path, char)
    return M.trim_left(M.trim_right(path, char), char)
end

--
-- Remove trailing and leading spaces from 'str'.
-- TODO: replace space with whitespace
function M.trim(path)
    return M.trim_left(M.trim_right(path, ' '), ' ')
end

function M.trim_right_slash(path)
    return M.trim_right(path, '/')
end

function M.trim_left_slash(path)
    return M.trim_left(path, '/')
end

--
-- Composes path using base path and subpath
--
-- @param path base path
-- @param sub subpath (nillable).
-- @return combined path (path/sub).
--  If sub is nil or empty, returns 'path'
function M.child(path, sub)
    local result = path
    if sub ~= nil and sub ~= '' then
        result = M.trim_right_slash(result) .. '/' .. M.trim_left_slash(sub)
    end
    return result
end

--
-- Finds item in table using predicate
--
-- @param t table
-- @param predicate function.
--  Function accepts table value and should return true if value matches.
-- @return index of found value or null
--
function M.findPredicate(t, predicate)
    for index, item in ipairs(t) do
        if predicate(item) then
            return index
        end
    end
end

--
-- Finds value in table
--
-- @param t table
-- @param value value to seardh
-- @return index of found value or null
--
function M.find(t, value)
    M.findPredicate(t, function(item)
        return item == value
    end)
end

--
-- Transform each item of the table using action
--
-- @param t table
-- @param action function
-- @return new table
--
function M.transform(t, action)
    local result = {}
    for _, item in ipairs(t) do
        local value = action(item)
        table.insert(result, value)
    end
    return result
end


--
-- Add all items of the second table to the first one
--
-- @param t1 first table
-- @param t2 second table
-- @return t1
--
function M.add(t1, t2)
    for i=1, #t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

--
-- Concatenate tables
--
-- @param vararg of tables
-- @return new table
--
function M.concat(...)
    local result = {}

    for _, table in ipairs({...}) do
        M.add(result, table)
    end

    return result
end

--
-- Filter table using filters.
-- 
-- @param t table
-- @param filters list of substrings.
--  If any of the substrings is found in the table value, the value is removed.
-- @return filtered table 't'
--
function M.filter(t, filters)
    for _, value in ipairs(filters) do
        local contains = function(str)
            return string.find(str, value, 0, true) ~= nil
        end

        local foundIndex = M.findPredicate(t, contains)

        if foundIndex ~= nil then
            table.remove(t, foundIndex)
        end
    end
    return t
end
--
-- Return file scheme if any
--
function M.get_scheme(file)
    local index = file:find(':', 1, true)
    return index and file:sub(1, index) or nil
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
-- Find any of specified files or directories starting from bufname or current 
-- buffer file and up to the FS root.
--
-- @param markers list of file or directory names to find
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
            local fullName = dirname .. "/" .. marker
            if vim.fn.filereadable(fullName) == 1 or vim.fn.isdirectory(fullName) == 1 then
                return dirname
            end
        end
        dirname = getparent(dirname)
    end
end

--
-- Returns list of files specifie by glob pattern
--
-- @param glob pattern
-- @return list of files
--
function M.get_files(pattern)
    local glob = vim.fn.glob(pattern, true)
    if #glob == 0 then
       return {}
    end
    return vim.split(glob, "\n")
end

--
-- Returns new instance of bufopts with specified 'desc'
-- 
function M.bufopts(bufopts, desc)
    -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
    return {
        noremap = bufopts.noremap,
        silent = bufopts.silent,
        buffer = bufopts.buffer,
        desc = desc
    }
end

--
-- Returns file content
--
-- @param file_path path to file
-- @return file content of nil if file does not exist
--
function M.load(file_path)
    local file = io.open(file_path, 'r')

    if not file then
        return nil
    end

    local content = file:read('*all')

    file:close()

    return content
end

return M
