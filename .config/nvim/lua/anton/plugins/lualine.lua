return {
    "nvim-lualine/lualine.nvim",

    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },

    opts = {
        options = {
            icons_enabled = true,
            -- theme = 'codedark',
            -- theme = 'material',
            theme = 'jellybeans',
            section_separators = '',
            component_separators = { left = '', right = '' }
        },

        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'%b[0x%B]', 'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },

        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
}
