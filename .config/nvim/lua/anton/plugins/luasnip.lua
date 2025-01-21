return {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    lazy = true,
    config = function ()
        local luasnip = require("luasnip")
        -- disable luasnip mapping since it configured via nvim-cmp
        -- require('anton.keymaps').luasnip_keymap(luasnip)

        require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
    end
}
