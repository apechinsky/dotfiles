return {
    "williamboman/mason.nvim",

    opts = {
        registries = {
            -- 'file:/home/apechinsky/.config/nvim/tools/my-mason-registry/',
            'github:mason-org/mason-registry',
        },

        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}
