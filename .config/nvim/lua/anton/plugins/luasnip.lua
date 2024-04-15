return {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    lazy = true,
    config = function ()
        local luasnip = require("luasnip")
        -- disable luasnip mapping since it configured via nvim-cmp
        -- require('anton.keymaps').luasnip_keymap(luasnip)
    end
}
