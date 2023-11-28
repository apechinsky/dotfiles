return {
    -- git integration
    'tpope/vim-fugitive',

    config = function ()
        -- Configure git log format for command 'Gclog'. Commit author is not visible by default
        vim.g.fugitive_summary_format = "%ai %ae %s"
    end
}
