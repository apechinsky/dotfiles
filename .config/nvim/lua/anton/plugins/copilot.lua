return {
    'github/copilot.vim',
    event = "VeryLazy",
    enabled = true,

    config = function ()
        local proxy = vim.fn.getenv('COPILOT_PROXY')
        if proxy ~= vim.NIL then
            vim.g.copilot_proxy = 'http://' .. proxy
        end

        vim.g.copilot_filetypes = {
            'md',
            'java'
        }

        vim.cmd("Copilot disable")
    end
}
