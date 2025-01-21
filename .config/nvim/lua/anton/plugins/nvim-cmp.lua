return {
    'hrsh7th/nvim-cmp',

    enabled = false,

    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lua',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },

    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- load relative to the directory of $MYVIMRC
        require("luasnip.loaders.from_lua").load({ paths = { "./snippets" } })
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = "path" },
                -- { name = "my" },
            },
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- },
            -- view = {
            --     entries = "custom",
            --     docs = {
            --         auto_open = true
            --     }
            -- },
            formatting = {
                fields = { 'abbr' },
                expandable_indicator = true,
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        buffer = "[buffer]",
                        nvim_lsp = "[lsp]",
                        luasnip = "[snip]",
                        nvim_lua = "[lua]",
                        my = "[my]",
                    })[entry.source.name]

                    return vim_item
                end
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<C-e>'] = cmp.mapping(function()
                    if luasnip.choice_active() then
                        luasnip.change_choice(1)
                    elseif cmp.visible() then
                        cmp.mapping.abort()
                    end
                end),
                -- Accept currently selected item.
                -- `false` - to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping(function(fallback)
                    if luasnip.expandable() then
                        luasnip.expand()
                    elseif cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

            }),
        })

        -- Set configuration for 'gitcommit' filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' },
                { name = 'buffer' },
            })
        })

        cmp.setup.filetype({ 'sql' }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            -- Commenting preset mapping because item
            -- it maps Tab/S-Tab to select_next_item() and this
            -- blocks standard vim path expansion behavior (:edit %:h<Tab>)
            -- mapping = cmp.mapping.preset.cmdline(),
            mapping = {
                ['<C-n>'] = {
                  c = function(fallback)
                    if cmp.visible() then
                      cmp.select_next_item()
                    else
                      fallback()
                    end
                  end,
                },
                ['<C-p>'] = {
                  c = function(fallback)
                    if cmp.visible() then
                      cmp.select_prev_item()
                    else
                      fallback()
                    end
                  end,
                },
                ['<C-e>'] = {
                  c = cmp.abort(),
                },
                ['<C-y>'] = {
                  c = cmp.confirm({ select = false }),
                },
            },

            sources = {
                { name = 'nvim_lua' },
                { name = 'buffer' },
                { name = 'path' },
                {
                    name = 'cmdline',
                    option = {
                        -- ignore because in a large project typing command like 'vimgrep test **/*'
                        -- causes recursive search and is too slow
                        ignore_cmds = { 'help', 'find', 'vimgrep', 'args', 'substitute' }
                    }
                }
            }
        })
    end
}
