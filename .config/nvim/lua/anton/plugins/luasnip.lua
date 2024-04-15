return {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    lazy = true,
    config = function ()
        local luasnip = require("luasnip")
        require('anton.keymaps').luasnip_keymap(luasnip)
    end
}
