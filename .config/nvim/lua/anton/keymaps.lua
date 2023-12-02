local vimutils = require('anton.core.utils')

local M = {}

local opts = { noremap = true, silent = true }

-- Do not jump to next occurence on *
vim.keymap.set('n', '*', '*N')

-- nvim-tree
vim.keymap.set('n', "<C-n>", vim.cmd.NvimTreeToggle, { desc = 'NvimTree Toggle' })
vim.keymap.set('n', "<Leader>nf", vim.cmd.NvimTreeFindFile, { desc = 'NvimTree Find current file' })

vim.keymap.set('n', "<Leader>cw", ":%s/\\s\\+$//g<CR>", { desc = 'Remove tailing whitespaces' })

-- Open current file in git web ui.
-- Define web ui root with 'git config remote.origin.webui'
vim.keymap.set('n', '<leader>go', function()
    require('anton.core.git').open_git_webui_current()
end, { desc = 'Open current file in Git web UI (remote.origin.webui)'} )

-- toggle undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })

-- translate shell
vim.g.trans_default_direction = ":ru"
vim.keymap.set('n', '<leader>d', vim.cmd.Trans, { desc = 'Translate' })

-- open vim terminal
vim.keymap.set('n', '<leader>tt', ":split term://zsh<CR>")

-- exit from insert mode in terminal with Esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<leader>yp', function()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Yank current file path to clipboard (+ register)' })

-- Replace buffer content with clipboard
-- gg - goto top, "_d - delete to null register to prevent (this keeps cliboard untouched)
-- p - paste
vim.keymap.set('n', '<leader>p', 'gg"_dGp<CR>', { desc = 'Replace buffer with clipboard' })

-- swap true/false values
vim.keymap.set('n', '<leader>s', ':call SwapBool()<CR>', { desc = 'Swap true/false' });

-- format XML
vim.keymap.set('n', '<F6>', ':call FormatXml()<CR>');

-- toggle line numbers
vim.keymap.set('n', '<F2>', ':call ToggleLineNumbers()<CR>')
vim.keymap.set('n', '<F3>', ':call ToggleRelativeLineNumbers()<CR>')

-- vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:make<CR>:cw<CR>', { noremap = true })
vim.keymap.set('n', '<F10>', ':wall<CR>:make<CR>:cw<CR>', { desc = 'Save and :make' })


-- luasnip mappings
local luasnip = require('luasnip')

vim.keymap.set({"s"}, "<tab>", function()
    if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end, opts)

vim.keymap.set({"i", "s"}, "<S-tab>", function()
    if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, opts)

vim.keymap.set({"i", "s"}, "<c-e>", function()
    if luasnip.choice_active() then luasnip.change_choice(1) end
end, opts)

vim.cmd([[
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    " -1 for jumping backwards.
    inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

    snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
    snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

    " For changing choices in choiceNodes (not strictly necessary for a basic setup).
    imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
    smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])

-- move selection up and down
-- vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- disable diagnostics by default
-- vim.diagnostic.disable()

-- See `:help vim.diagnostic.*` for documentation on any of the below functions

vim.keymap.set('n', '<leader>de', vim.diagnostic.enable, opts)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable, opts)
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

M.lsp_keymap = function(bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>fm', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

require("which-key").register({
    g = {
        name = "LSP keys",
    },
}, { prefix = "<leader>" })

M.java_keymap = function(jdtls, bufopts)
    vim.keymap.set('n', '<leader>tm', function()
        require('anton.java.gradle').find():run_java_test_method()
    end, vimutils.bufopts(bufopts, 'Run current test method'))

    vim.keymap.set('n', '<leader>tc', function()
        require('anton.java.gradle').find():run_java_test_class()
    end, vimutils.bufopts(bufopts, 'Run current test class'))

    vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, { desc = "Organize imports" } )
    vim.keymap.set("n", "<leader>vc", jdtls.test_class, { desc = "Test class (DAP)" } )
    vim.keymap.set("n", "<leader>vm", jdtls.test_nearest_method, { desc = "Test method (DAP)"})
    vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, { desc = "Extract variable"})
    vim.keymap.set("n", "<leader>ec", jdtls.extract_constant, { desc = "Extract constant"})
    vim.keymap.set("v", "<leader>em", jdtls.extract_method, { desc = "Extract method"})
end

M.dap_keymap = function(dap, bufopts)
    vim.keymap.set('n', '<F7>', function()
        dap.step_into()
    end, vimutils.bufopts(bufopts, 'Debug. Step into.'))

    vim.keymap.set('n', '<F8>', function()
        dap.step_over()
    end, vimutils.bufopts(bufopts, 'Debug. Step over.'))

    vim.keymap.set('n', '<F9>', function()
        dap.continue()
    end, vimutils.bufopts(bufopts, 'Debug. Continue.'))

    vim.keymap.set('n', '<F32>', function()
        dap.toggle_breakpoint()
    end, vimutils.bufopts(bufopts, 'Debug. Toggle breakpoint.'))
end

require("which-key").register({
    t = {
        name = "terminal",
    },
}, { prefix = "<leader>" })

return M
