vim.opt.suffixes:append({ '.java' })

vim.opt.makeprg = 'javac %'

vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':wall<CR>:make<CR>', { noremap = true })

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!jbang %<CR>', { noremap = true })

vim.opt.tags:append({
    "/home/apechinsky/ctags/libs/java-libs.tags",
    "/home/apechinsky/ctags/libs/jdk-1.8.0.tags"
})

vim.opt.colorcolumn = { 80, 130 }

-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = red })
vim.cmd("highlight ColorColumn ctermbg=darkgray")

