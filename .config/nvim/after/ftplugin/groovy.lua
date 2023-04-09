vim.opt_local.suffixes:append({ '.groovy' })

vim.opt_local.colorcolumn = { 80, 100, 130 }

vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!groovy %<CR>', { noremap = true })

vim.opt_local.tags:append({
    "/home/apechinsky/ctags/libs/java-libs.tags",
    "/home/apechinsky/ctags/libs/jdk-1.8.0.tags"
})

-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = red })
vim.cmd("highlight ColorColumn ctermbg=darkgray")
