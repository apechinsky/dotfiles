
vim.opt.makeprg = 'node %'

vim.opt.suffixes:append({ '.js', '.ts' })

vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!node %<CR>', { noremap = true })
