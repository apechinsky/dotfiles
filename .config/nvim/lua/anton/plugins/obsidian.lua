return {
    "epwalsh/obsidian.nvim",
    tag = "v3.8.1",
    lazy = true,
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Dropbox/obsidian/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Dropbox/obsidian/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "test",
                path = "~/Dropbox/obsidian/test",
            },
            -- {
            --     name = "personal",
            --     path = "~/Dropbox/obsidian/personal",
            -- },
            -- {
            --     name = "work",
            --     path = "~/Dropbox/obsidian/personal",
            -- },
        },

        -- see below for full list of options 👇
    },
}
