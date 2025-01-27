return {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    version = "v2.*",
    lazy = true,

    dependencies = {
        'rafamadriz/friendly-snippets',
    },

    config = function ()
        -- local luasnip = require("luasnip")
        -- disable luasnip mapping since it configured via nvim-cmp
        -- require('anton.keymaps').luasnip_keymap(luasnip)

        require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
