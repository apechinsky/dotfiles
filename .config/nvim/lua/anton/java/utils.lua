--
-- Java utilities
--
local M = {}

function M.by_or(...)
    local predicates = { ... }
    return function(node)
        for _, predicate in ipairs(predicates) do
            if predicate(node) then
                return true
            end
        end
        return false
    end

end

--
-- Returns function-predicate checking if TSNode type equals to specified value
--
function M.by_type(type)
    return function(node)
        return node:type() == type
    end
end

--
-- Finds an ancestor of the given 'node' that conforms 
-- to the specified predicate.
--
-- @param node starting node
-- @param predicate a predicate function
--
function M.find_parent(node, predicate)
    while node do
        if predicate(node) then
            return node
        end
        node = node:parent()
    end
end

--
-- Finds a child of the given 'node' that conforms to the 
-- specified predicate.
--
-- @param node starting node
-- @param predicate a predicate function
--
function M.find_child(node, predicate)
    for i = 0, node:child_count() - 1 do
        if predicate(node:child(i)) then
            return node:child(i)
        end
    end
end

function M.get_current_method()
    local current_node = vim.treesitter.get_node()
    if not current_node then return nil end

    local method = M.find_parent(current_node, M.by_or(M.by_type('method_declaration'), M.by_type('constructor_declaration')))
    if not method then return nil end

    local method_name = M.find_child(method, M.by_type('identifier'))
    if not method_name then return nil end

    return vim.treesitter.get_node_text(method_name, 0)
end

function M.get_current_method_parameters()
    local current_node = vim.treesitter.get_node()
    if not current_node then return nil end

    local method = M.find_parent(current_node, M.by_type('method_declaration'))
    if not method then return nil end

    local parameters = M.find_child(method, M.by_type('formal_parameters'))
    if not parameters then return nil end

    local result = {}

    for i = 0, parameters:child_count() - 1 do
        local parameter = parameters:child(i)
        local parameter_name = M.find_child(parameter, M.by_type('identifier'))
        if parameter_name then
            table.insert(result, vim.treesitter.get_node_text(parameter_name, 0))
        end
    end

    return result
end

function M.get_current_class()
    local current_node = vim.treesitter.get_node()
    if not current_node then return nil end

    local class_declaration = M.find_parent(current_node, M.by_type('class_declaration'))
    if not class_declaration then return nil end

    local class_name = M.find_child(class_declaration, M.by_type('identifier'))
    if not class_name then return nil end

    return vim.treesitter.get_node_text(class_name, 0)
end

function M.get_current_class_from_file()
    local current_file = require('anton.utils').get_current_file()
    return vim.fn.fnamemodify(current_file, ':t:r')
end

function M.get_current_package()
    local current_node = vim.treesitter.get_node()
    if not current_node then return nil end

    local program_expr = M.find_parent(current_node, M.by_type('program'))
    if not program_expr then return nil end

    local package_expr = M.find_child(program_expr, M.by_type('package_declaration'))
    if not package_expr then return nil end

    local child = M.find_child(package_expr, M.by_type('scoped_identifier'))
    if not child then return nil end

    return vim.treesitter.get_node_text(child, 0)
end

function M.get_current_class_full()
    local package = M.get_current_package()
    local class = M.get_current_class()
    return package and class and package .. '.' .. class
end

function M.get_current_method_full(delimiter)
    delimiter = delimiter or '.'
    local class_name = M.get_current_class_full()
    local method_name = M.get_current_method()
    return class_name and method_name and class_name .. delimiter .. method_name
end



return M
