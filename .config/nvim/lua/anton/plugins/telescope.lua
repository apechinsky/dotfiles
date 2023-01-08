require('telescope').setup({
    defaults = {
        initial_mode = "insert",

        layout_config = {
            vertical = { width = 0.2 }
        },
        path_display = { "smart" }
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
})

-- load fzf-native extension
require('telescope').load_extension('fzf')

