vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':%!envsubst<CR>', { noremap = true })

vim.opt_local.equalprg = 'xmllint --format --recover - 2>/dev/null'
