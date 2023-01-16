-- configure colorschemes

--
-- Fix 'habamax' colorscheme colors
-- habamax is good colorscheme but has some minor deficiencies need to be fixed
--
function FixHabamaxColors()
    -- Fix vim-signify colors
    vim.cmd("highlight SignifySignAdd    ctermfg=green  guifg=#008800 cterm=NONE gui=NONE")
    vim.cmd("highlight SignifySignDelete ctermfg=red    guifg=#880000 cterm=NONE gui=NONE")
    vim.cmd("highlight SignifySignChange ctermfg=yellow guifg=#888800 cterm=NONE gui=NONE")

    -- Fix match brace colors
    vim.cmd("highlight MatchParen ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black")
end

vim.cmd([[
augroup FixHabamaxColors
    autocmd!
    autocmd ColorScheme habamax call v:lua.FixHabamaxColors()
augroup END
]])

vim.cmd.colorscheme("habamax")

--vim.cmd.colorscheme("gruvbox")
