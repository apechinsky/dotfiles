local setup, nvimtree = pcall(require, "nvim-tree")

if not setup then
    print "warning: nvim-tree plugin not found!"
    return
end

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    sync_root_with_cwd = false,

    view = {
        width = 40,
    },

    filters = {
      dotfiles = false,
    },
})
