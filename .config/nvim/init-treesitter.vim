" Treesitter plugin config

lua <<END
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {sh},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ensure_installed = {
        "java"
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim 
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                -- Or you can define your own textobjects like this
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    java = "(method_declaration) @function",
                },
            },
        },
        indent = {
            enable = true
        }
    },
}

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
END

" local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
" parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
"
noremap <F3> :TSBufEnable highlight<CR>
noremap <F4> :TSBufDisable highlight<CR>
