return {
    'nvim-telescope/telescope.nvim',

    tag = '0.1.6',

    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-tree/nvim-web-devicons',
    },

    opts = {
        defaults = {
            initial_mode = "insert",

            sorting_strategy = "ascending",

            layout_strategy = 'flex',

            layout_config = {
                horizontal = {
                    height = 0.95,
                    preview_cutoff = 20,
                    prompt_position = "top",
                    width = 0.95
                },
                vertical = {
                    height = 0.95,
                    preview_cutoff = 10,
                    prompt_position = "top",
                    width = 0.95
                }
            },

            path_display = { "truncate" },
        },

        pickers = {
            find_files = {
                hidden = true
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        },
    },

    init = function()
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('ui-select')

        local builtin = require('telescope.builtin')
        require('anton.keymaps').telescope_keymap(builtin)
    end
}
