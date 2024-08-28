return {
    'nvim-tree/nvim-tree.lua',

    opts = {
        sync_root_with_cwd = false,

        auto_reload_on_write = true,

        view = {
            width = 40,
        },

        filters = {
            dotfiles = true,
        },

        notify = {
            threshold = vim.log.levels.WARNING,
            absolute_path = true,
        },
    }
}
