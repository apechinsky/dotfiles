
vim.o.textwidth = 80

vim.opt_local.suffixes:append({ '.ad', '.adoc', '.asciidoc' })

vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':!asciidoctorj --require asciidoctor-diagram *<CR>', { noremap = true })
