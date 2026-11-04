
vim.opt.suffixes:append({ '.kt' })

vim.opt.makeprg = 'kotlinc %'

-- vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':wall<CR>:make<CR>', { noremap = true })

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.api.nvim_buf_set_keymap(0, 'n', '<F11>', ':wall<CR>:make<BAR>!kotlin %:rKt<CR>', { noremap = true })

-- Gradle tests (the same Gradle class as for Java, see anton/java/gradle.lua)
local function gradle_map(lhs, action, desc)
    vim.keymap.set('n', lhs, function()
        local project = require('anton.java.gradle').find(require('anton.core.utils').get_current_file())
        if project then
            action(project)
        else
            vim.notify('Gradle project not found', vim.log.levels.ERROR)
        end
    end, { buffer = true, silent = true, desc = desc })
end

gradle_map('<leader>tm', function(gradle) gradle:run_kotlin_test_method() end,
    'Run current test method (via gradle)')
gradle_map('<leader>tc', function(gradle) gradle:run_kotlin_test_class() end,
    'Run current test class (via gradle)')
gradle_map('<leader>ta', function(gradle) gradle:run_kotlin_test_module() end,
    'Run all tests of the current module (via gradle)')
gradle_map('<leader>tk', function(gradle) gradle:run_check() end,
    'Run gradle check')

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
