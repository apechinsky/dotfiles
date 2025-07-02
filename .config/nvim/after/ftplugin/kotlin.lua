
vim.opt.suffixes:append({ '.kt' })

vim.opt.makeprg = 'kotlinc %'

-- vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':wall<CR>:make<CR>', { noremap = true })

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.api.nvim_buf_set_keymap(0, 'n', '<F11>', ':wall<CR>:make<BAR>!kotlin %:rKt<CR>', { noremap = true })

-- local dap = require('dap')
--
-- dap.configurations.kotlin = {
--     {
--         type = 'kotlin',
--         request = 'launch',
--         name = 'Debug (Attach)',
--         hostName = 'localhost',
--         port = 5005,
--     },
-- }


-- dap.configurations.kotlin = {
--     {
--         type = 'kotlin';
--         request = 'launch';
--         name = "Launch file";
--         program = "${file}";
--     },
-- }
