return {
    'lewis6991/gitsigns.nvim',

    enabled = true,

    opts = {
        signs = {
            add          = { text = '+' },
            change       = { text = '!' },
            delete       = { text = '-' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
          },
    }
}
