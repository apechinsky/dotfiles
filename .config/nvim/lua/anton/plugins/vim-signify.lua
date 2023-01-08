-- vim-signify plugin. show VCS diffs in signcolumn

vim.cmd("highlight SignifySignAdd    ctermfg=green  guifg=#008800 cterm=NONE gui=NONE")
vim.cmd("highlight SignifySignDelete ctermfg=red    guifg=#880000 cterm=NONE gui=NONE")
vim.cmd("highlight SignifySignChange ctermfg=yellow guifg=#888800 cterm=NONE gui=NONE")
