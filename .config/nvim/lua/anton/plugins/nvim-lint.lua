return {
    'mfussenegger/nvim-lint',

    event = {
        'BufReadPre',
        'BufNewFile',
    },

    config = function ()
        local lint = require('lint')

        lint.linters_by_ft = {
            asciidoc = { 'vale' },
            markdown = { 'markdownlint', 'vale' },
            vimwiki = { 'markdownlint', 'vale' },
            -- sh = { 'shellcheck' },
        }

        local augroup = vim.api.nvim_create_augroup('lint', { clear = true} )
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end

}
