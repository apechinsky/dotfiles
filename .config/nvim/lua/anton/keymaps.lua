vim.g.mapleader = " "
vim.g.maploacalleader = vim.g.mapleader

-- Do not jump to next occurence on *
vim.keymap.set('n', '*', '*N')

-- vim.keymap.set('n', "<leader>+", "<C-a>")
-- vim.keymap.set('n', "<leader>-", "<C-x>")

-- move selection up and down
-- vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- nvim-tree
vim.keymap.set('n', "<C-n>", ":NvimTreeToggle<CR>")

-- toggle undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- translate shell
vim.g.trans_default_direction = ":ru"
vim.keymap.set('n', '<leader>d', vim.cmd.Trans)

-- open vim terminal
vim.keymap.set('n', '<leader>tt', ":split term://zsh<CR>")

-- exit from insert mode in terminal with Esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Copy current file path to clipboard
vim.keymap.set('n', '<leader>c', ':let @+ = expand("%:p")<CR>')

-- Replace buffer content with clipboard
-- gg - goto top, "_d - delete to null register to prevent (this keeps cliboard untouched)
-- p - paste
vim.keymap.set('n', '<leader>p', 'gg"_dGp<CR>')

-- swap true/false values
vim.keymap.set('n', '<leader>s', ':call SwapBool()<CR>');

-- format XML
vim.keymap.set('n', '<F6>', ':call FormatXml()<CR>');

-- toggle line numbers
vim.keymap.set('n', '<F2>', ':call ToggleLineNumbers()<CR>')


-- luasnip mappings
local opts = { noremap = true, silent = true }
vim.keymap.set({"i", "s"}, "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
vim.keymap.set({"i", "s"}, "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
