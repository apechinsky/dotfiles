local config = {

    path = vim.fn.stdpath('config')

}

local function subpath(path, sub)
    local separator = string.sub(path, #path, #path) == '/'
        and ''
        or '/'

    return path .. separator .. sub
end

function config.subpath(sub)
    return subpath(config.path, sub)
end

function config.tools(sub)
    return subpath(config.subpath('tools'), sub)
end

return config
