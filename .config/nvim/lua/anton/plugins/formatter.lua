-- Formatters configuration with 'stevearc/conform' plugin
return {
    'stevearc/conform.nvim',

    event = {
        'BufReadPre',
        'BufNewFile',
    },

    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            css = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            yaml = { 'prettier' },
            markdown = { 'prettier' },
        },

        -- Customize formatters
        formatters = {
            -- shfmt = {
            --     prepend_args = { "-i", "2" },
            -- },
        },
    },

    config = function()
        vim.keymap.set({ 'n', 'v' }, '<leader>fp', function()
            require('conform').format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500
            })
        end, { desc = 'Format file or selection' })
    end,

    init = function()
        -- If you want the formatexpr, here is the place to set it
        -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}


