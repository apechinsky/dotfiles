
vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!./%<CR>', { noremap = true })

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

vim.opt_local.makeprg = '%'
vim.opt_local.errorformat = '%f: line %l: %m'

