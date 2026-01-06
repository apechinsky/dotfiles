return {
    'saghen/blink.cmp',

    version = '*',

    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },

    opts = {
        keymap = { preset = 'default' },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
        snippets = {
            preset = 'luasnip'
        },
        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
            },
        },
    },
}
