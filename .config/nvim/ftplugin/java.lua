vim.opt.suffixes:append({ '.java' })

vim.opt.makeprg = 'javac %'

vim.keymap.set('n', '<F9>', ":w<CR>:make<CR>")

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.keymap.set('n', '<F10>', ":w<CR>:!jbang %<CR>")

vim.opt.tags:append({
    "/home/apechinsky/ctags/libs/java-libs.tags",
    "/home/apechinsky/ctags/libs/jdk-1.8.0.tags"
})

vim.opt.colorcolumn = { 80, 130 }

-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = red })
vim.cmd("highlight ColorColumn ctermbg=darkgray")

