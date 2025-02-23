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

    -- Fix. Float window border is not visible since
    -- FloatBorder -> WinSeparator -> VertSplit which use thes same color
    -- background and foreground.
    -- So we link VertSplit to Normal
    vim.cmd("highlight! link VertSplit Normal")
    vim.cmd("highlight! link NormalFloat Normal")

    -- Fix match brace colors
    -- vim.cmd("highlight MatchParen ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black")
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("FixHabamaxColors", { clear = true }),

    callback = function()
        FixHabamaxColors()
    end
})

vim.cmd.colorscheme("habamax")

