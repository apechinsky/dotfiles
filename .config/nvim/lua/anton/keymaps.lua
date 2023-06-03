local M = {}

vim.g.mapleader = " "
vim.g.maploacalleader = vim.g.mapleader

-- Do not jump to next occurence on *
vim.keymap.set('n', '*', '*N')

-- vim.keymap.set('n', "<leader>+", "<C-a>")
-- vim.keymap.set('n', "<leader>-", "<C-x>")

-- nvim-tree
vim.keymap.set('n', "<C-n>", vim.cmd.NvimTreeToggle, { desc = 'NvimTree Toggle' })
vim.keymap.set('n', "<Leader>nf", vim.cmd.NvimTreeFindFile, { desc = 'NvimTree Find current file' })

-- toggle undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind recently opened files' })


-- translate shell
vim.g.trans_default_direction = ":ru"
vim.keymap.set('n', '<leader>d', vim.cmd.Trans, { desc = 'Translate' })

-- open vim terminal
vim.keymap.set('n', '<leader>tt', ":split term://zsh<CR>")

-- exit from insert mode in terminal with Esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Copy current file path to clipboard
-- vim.keymap.set('n', '<leader>c', ':let @+ = expand("%:p")<CR>')

-- Replace buffer content with clipboard
-- gg - goto top, "_d - delete to null register to prevent (this keeps cliboard untouched)
-- p - paste
vim.keymap.set('n', '<leader>p', 'gg"_dGp<CR>', { desc = 'Replace buffer with clipboard'})

-- swap true/false values
vim.keymap.set('n', '<leader>s', ':call SwapBool()<CR>', { desc = 'Swap true/false' });

-- format XML
vim.keymap.set('n', '<F6>', ':call FormatXml()<CR>');

-- toggle line numbers
vim.keymap.set('n', '<F2>', ':call ToggleLineNumbers()<CR>')


-- luasnip mappings
local opts = { noremap = true, silent = true }
vim.keymap.set({"i", "s"}, "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set({"i", "s"}, "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

-- move selection up and down
-- vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")

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
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>fm', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
end

return M
