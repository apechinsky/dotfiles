return {
    'mfussenegger/nvim-dap',

    init = function()
        local bufopts = { noremap = true, silent = true }
        require('anton.keymaps').dap_keymap(require('dap'), bufopts)

        -- vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error', linehl = '', numhl = '' })
        -- vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
        -- vim.fn.sign_define('DapLogPoint', { text = '', texthl = '', linehl = '', numhl = '' })
        -- vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })
        -- vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = '', linehl = '', numhl = '' })
        --
        local dapGroup = vim.api.nvim_create_augroup('DAP group', { clear = true })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { '*.dap-repl' },
            callback = function()
                require('dap.ext.autocompl').attach()
            end,
            group = dapGroup,
        })
    end
}
