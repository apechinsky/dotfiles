--
-- Utilities which is used in configuration files.
--

local utils = {}

--
-- return value from "key='value'" expression
--
function utils.getValue(keyValue)
    for k, v in string.gmatch(keyValue, "(%w+)%s*=%s*[\'\"](%w+)[\'\"]%s*") do
        if k ~= nil then
            return v
        end
    end
end

--
-- returns value of property with specified key from given file.
--
function utils.getProperty(file, key)
    for line in io.lines(file) do
        local s, e = string.find(line, key)
        if s ~= nil then
            return utils.getValue(line)
        end
    end
end

return utils
