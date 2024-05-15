return {
    'github/copilot.vim',
    event = "VeryLazy",
    enabled = true,

    config = function ()
        local proxy = vim.fn.getenv('DO_PROXY')
        if proxy ~= nil then
            local proxy_auth = vim.fn.getenv('DO_PROXY_AUTH')
            if proxy_auth == nil then
                proxy_auth = ''
            end
            vim.g.copilot_proxy = 'http://' .. proxy_auth .. '@164.90.187.109:3128'
        end

        vim.g.copilot_filetypes = {
            'md',
            'java'
        }
    end
}
