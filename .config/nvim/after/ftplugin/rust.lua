local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
    "n",
    "<leader>a",
    function()
        -- supports rust-analyzer's grouping
        vim.cmd.RustLsp('codeAction')
        -- or if you don't want grouping.
        -- vim.lsp.buf.codeAction()
    end,
    { silent = true, buffer = bufnr }
)
vim.keymap.set(
    "n",
    -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    "K",
    function()
        vim.cmd.RustLsp({'hover', 'actions'})
    end,
    { silent = true, buffer = bufnr }
)
