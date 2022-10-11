" Telescope plugin configuration

" Find files using Telescope command-line sugar.
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>

nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_bcommits<cr>

lua << END
require('telescope').setup({
    defaults = {
        initial_mode = "normal",

        layout_config = {
            vertical = { width = 0.2 }
            -- other layout configuration here
        },
        path_display = { "truncate" }
        -- other defaults configuration here
    },
    find_files = {
        layout_strategy = 'horizontal',
        layout_config = {
            width=0.5
        }
    }

-- other configuration values here
})
END

