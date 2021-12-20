" Telescope plugin configuration

" Find files using Telescope command-line sugar.
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>

lua << END
require('telescope').setup({
defaults = {
    layout_config = {
        vertical = { width = 0.2 }
        -- other layout configuration here
        },
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

