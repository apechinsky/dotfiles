return {
    'hrsh7th/nvim-cmp',

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

    config = function ()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.register_source('my', require('anton.my-cmp-source'))

        -- load relative to the directory of $MYVIMRC
        require("luasnip.loaders.from_lua").load({ paths = "./mysnippets" })
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "./mysnippets" })

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
                { name = "my" },
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
                ['<C-e>'] = cmp.mapping.abort(),
                -- Accept currently selected item.
                -- `false` - to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-j"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
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

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        -- cmp.setup.cmdline({ '/', '?' }, {
        --     mapping = cmp.mapping.preset.cmdline(),
        --     sources = {
        --         { name = 'buffer' }
        --     }
        -- })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'nvim_lua' },
                { name = 'buffer' },
                { name = 'path' },
                {
                    name = 'cmdline',
                    option = {
                        -- ignore because in a large project typing command like 'vimgrep test **/*' 
                        -- causes recursive search and is too slow
                        ignore_cmds = { 'vimgrep', 'args' }
                    }
                }
            }
        })
    end
}
