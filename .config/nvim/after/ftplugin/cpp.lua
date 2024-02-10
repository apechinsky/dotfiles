vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!g++ % -ggdb -fno-elide-constructors -o %:r && %:r <CR>', { noremap = true })
