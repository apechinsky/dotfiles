return {
    'hrsh7th/nvim-cmp',

    enabled = true,

    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
    },

    config = function ()
        -- vim.opt.completeopt = "menu,menuone,noselect"

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- vim.opt.completeopt='menu,menuone,noselect'

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- },
            view = {
                entries = "custom",
                docs = {
                    auto_open = true
                }
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        buffer = "[buffer]",
                        nvim_lsp = "[lsp]",
                        luasnip = "[snip]",
                        nvim_lua = "[lua]",
                    })[entry.source.name]

                    return vim_item
                end
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),

                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),

                -- Accept currently selected item.
                -- `false` - to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = "path" },
            })
        })

        -- Set configuration for 'gitcommit' filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' },
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                {
                    name = 'cmdline',
                    option = {
                        -- ignore because in a large project typing command like 'vimgrep test **/*' 
                        -- causes recursive search and is too slow
                        ignore_cmds = { 'vimgrep' }
                    }
                }
            })
        })
    end
}
