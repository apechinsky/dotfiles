--
-- Java utilities
--
local M = {}

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

    local method = M.find_parent(current_node, M.by_type('method_declaration'))
    if not method then return nil end

    local method_name = M.find_child(method, M.by_type('identifier'))
    if not method_name then return nil end

    return vim.treesitter.get_node_text(method_name, 0)
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