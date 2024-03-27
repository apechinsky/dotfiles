-- Treesitter configuration
--
-- https://github.com/tree-sitter/tree-sitter
-- https://github.com/nvim-treesitter/nvim-treesitter
--
return {
    'nvim-treesitter/nvim-treesitter',

    event = { "BufReadPre", "BufNewFile" },

    build = ":TSUpdate",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },

    main = 'nvim-treesitter.configs',

    opts = {
        ensure_installed = {
            "c",
            "lua",
            "java",
            "javascript",
            "typescript",
            "json",
            "yaml",
            "ruby",
            "http",
            "pkl"
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        indent = {
            enable = true,
            -- disable = { 'python' }
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                -- set to `false` to disable one of the mappings
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V',  -- linewise
                    ['@class.outer'] = '<c-v>', -- blockwise
                },
                include_surrounding_whitespace = false,
            },

            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                    ['<leader>mf'] = '@function.outer',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                    ['<leader>MF'] = '@function.outer',
                },
            },
        },
    },

    -- config = function(_, opts)
    --     require('nvim-treesitter.configs').setup(opts)
    -- end
}
