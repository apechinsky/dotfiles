
vim.opt.suffixes:append({ '.kt' })

vim.opt.makeprg = 'kotlinc %'

-- vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':wall<CR>:make<CR>', { noremap = true })

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.api.nvim_buf_set_keymap(0, 'n', '<F11>', ':wall<CR>:make<BAR>!kotlin %:rKt<CR>', { noremap = true })
