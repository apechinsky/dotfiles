""" ALE configuration

" Disable ALE LSP since neovim has built-in LSP
let g:ale_disable_lsp = 1

" Only run linters named in ale_linters settings.
" let g:ale_linters_explicit = 1

highlight RedundantSpaces ctermbg=bg guibg=bg
match RedundantSpaces /\s\+$/

highlight ALEWarning ctermbg=DarkMagenta
highlight ALEError ctermbg=Red
" highlight ALEErrorSign
" highlight ALEWarningSign

let g:ale_linters = {
\   'java': ['checkstyle', 'eclipselsp', 'javac', 'javalsp', 'pmd'],
\   'javascript': ['eslint'],
\   'asciidoc': ['alex'],
\   'markdown': ['alex'],
\   'bash': ['bashate', 'language_server', 'shell', 'shellcheck'],
\   'sh': ['bashate', 'language_server', 'shell', 'shellcheck'],
\}

" Disable cspell because it applied almost every type and it's too wordy
let g:ale_linters_ignore = ['cspell']

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'autoimport', 'autoflake', 'isort'],
\   'javascript': ['eslint'],
\}
