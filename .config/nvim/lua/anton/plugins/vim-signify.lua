-- vim-signify plugin. show VCS diffs in signcolumn
return {
    'mhinz/vim-signify',

    -- disable plugin because it causes en errors with Lazy
    -- replace with gitsigns
    enabled = false,

    init = function ()
        vim.cmd([[
            highlight SignifySignAdd    ctermfg=green  guifg=#008800 cterm=NONE gui=NONE
            highlight SignifySignDelete ctermfg=red    guifg=#880000 cterm=NONE gui=NONE
            highlight SignifySignChange ctermfg=yellow guifg=#888800 cterm=NONE gui=NONE
        ]])
    end
}
