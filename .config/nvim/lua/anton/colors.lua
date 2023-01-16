function FixHabamaxColors()
    vim.cmd([[highlight SignifySignAdd ctermfg=green  guifg=#008800 cterm=NONE gui=NONE]])
    vim.cmd([[highlight MatchParen ctermfg=green  guifg=#009900 cterm=NONE gui=NONE]])
end

vim.cmd([[
    augroup FixHabamaxColors
        autocmd!
        autocmd ColorScheme habamax call v:lua.FixHabamaxColors()
    augroup end
]])

vim.cmd([[colorscheme habamax]])
