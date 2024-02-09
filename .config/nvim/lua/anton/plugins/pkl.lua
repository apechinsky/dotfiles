return {
    "apple/pkl-neovim",

    lazy = true,

    event = "BufReadPre *.pkl",

    build = function()
        vim.cmd("TSInstall! pkl")
    end,
}
