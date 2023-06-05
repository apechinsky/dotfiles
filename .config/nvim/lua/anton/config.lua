local config = {

    config = vim.fn.stdpath('config'),

    data = vim.fn.stdpath('data'),

    cache = vim.fn.stdpath('cache'),

    configPath = function(path)
        return subpath(config.config, path)
    end

}

local function removeTrailing(path, char)
    return string.sub(path, #path, #path) == char
        and string.sub(path, 1, #path - 1)
        or path
end

local function removeLeading(path, char)
    return string.sub(path, 1, 1) == char
        and string.sub(path, 2, #path)
        or path
end

local function removeTrailingSlash(path)
    return removeTrailing(path, '/')
end

local function removeLeadingSlash(path)
    return removeLeading(path, '/')
end

local function subpath(path, sub)
    return removeTrailingSlash(path) .. "/" .. removeLeadingSlash(sub)
end

function config.subpath(sub)
    return subpath(config.config, sub)
end

function config.tools(sub)
    return subpath(config.subpath('tools'), sub)
end

return config
