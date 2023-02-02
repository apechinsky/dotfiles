require("anton.plugins-setup")

if packer_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

require("anton.keymaps")
require("anton.functions")
require("anton.options")
require("anton.filetypes")
require("anton.colors")
require("anton.plugins.comment")
require("anton.plugins.nvim-tree")
require("anton.plugins.lualine")
require("anton.plugins.telescope")
require("anton.plugins.nvim-cmp")
require("anton.plugins.treesitter")
require("anton.plugins.vim-fugitive")
require("anton.plugins.vim-signify")
require("anton.plugins.vimwiki")
require("anton.plugins.autopairs")
require("anton.plugins.lspconfig")
require("anton.keymaps")
