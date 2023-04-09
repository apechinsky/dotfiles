
vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!awk -f %', { noremap = true })
