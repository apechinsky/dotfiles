require('lualine').setup({
    options = {
        icons_enabled = true,
        -- theme = 'codedark',
        -- theme = 'material',
        theme = 'jellybeans',
        section_separators = '',
        component_separators = { left = '', right = '' }
    },

    -- sections = {
    --     lualine_a = {
    --     },
    --     lualine_b = {'branch', 'diff', 'diagnostics'},
    --     lualine_c = { { 'filename', path=1 } },
    --     lualine_x = {'encoding', 'fileformat', 'filetype'},
    --     lualine_y = {'progress'},
    --     lualine_z = {'location'}
    -- }
})
