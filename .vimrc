""" Vim editor configuration

""" vim-plug plugin manager (https://github.com/junegunn/vim-plug)

" vim-plug. Automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug. Configuration
call plug#begin('~/.vim/plugged')

" Fuzzy finder.
" Method 1. Install fzf viz vim plugin
" After installation FZF will be available from command line also.
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Method 2. Install fzf externally and declare plugin
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Directory tree explorer plugin for vim (Ctrl-N)
Plug 'scrooloose/nerdtree'

" vimdiff for directories
Plug 'will133/vim-dirdiff'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Plug 'vim-scripts/tComment'
Plug 'tpope/vim-commentary'

" Git integration
Plug 'tpope/vim-fugitive'

"
Plug 'preservim/tagbar'

Plug 'editorconfig/editorconfig-vim'

" Personal Wiki for Vim http://vimwiki.github.io/
Plug 'vimwiki/vimwiki'

" SnipMate and snippets
" SnipMate aims to provide support for textual snippets, similar to TextMate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-surround'

""" Color management plugins

" Color schemes
Plug 'morhetz/gruvbox'

" platformio support (leader-c - compile, leader-d - compile&deploy)
Plug 'apechinsky/vim-platform-io'

" Swift language support
Plug 'bumaociyuan/vim-swift'

" Kotlin language support
Plug 'udalov/kotlin-vim'

" Javascript plugin
Plug 'pangloss/vim-javascript'

" Vim-script library, which provides some utility functions and commands for programming in Vim.
Plug 'vim-scripts/L9'

Plug 'vim-scripts/matchit.zip'

" Translate shell integration
Plug 'echuraev/translate-shell.vim'

" Plug 'codota/tabnine-vim'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'

Plug 'mbbill/undotree'

Plug 'itchyny/lightline.vim'

Plug 'natebosch/vim-lsc'

call plug#end()
" END vim-plug configuration

" Terminal encoding
set termencoding=utf-8

" File encodings and detection order
set fileencodings=utf8,cp1251

" Enable line numbers
set number
" Enable relative numbers
set relativenumber

" Disable backup files creation
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

" Disable line wrapping
set nowrap

" prevent new line at the EOF
set noeol

" position new window right
set splitright

set autoindent

set wildmenu
set path+=**

" Set tabulation
set expandtab
set tabstop=4
set shiftwidth=4

" Enable switch buffer if current is unsaved
set hidden

" set textwidth=100

set pastetoggle=<F5>

" Show cursor position
set ruler

" Enable incremental search
set incsearch

set scrolloff=6

" Ignore case if search string is in lowercase. Otherwise use case sensitive search.
set ignorecase smartcase

" Allow to put/get yanked text to system clipboard (unnamedplus) or X11-selection (unnamed)
" Check Vim xterm_clipboard option with (vim --version). If no option, install vim-gtk package
set clipboard=unnamedplus
" Prevent clipboard from being cleared on exit
autocmd VimLeave * call system("xclip -o -sel clip | xclip -sel clip")

" Enable spell highlighting with gruvbox theme
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
" colorscheme codedark
" colorscheme zenburn
" autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_termcolors=256
set background=dark

""" Status line

" Always show status line
set laststatus=2

" Standard statusline configuration
" set statusline=
" set statusline+=#%n
" set statusline+=\ %f
" set statusline+=\ %y
" set statusline+=\ %{FugitiveStatusline()}
" set statusline+=%=
" set statusline+=\ char:%b[0x%B]
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}\]
" set statusline+=\ %2l:%-2c\ [%L/%p%%]

" lightline plugin statusline configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'gitbranch', 'readonly', 'filename', 'modified', 'char']
      \   ]
      \ },
      \ 'component': {
      \   'char': '%3b/%Bh',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

set undodir=~/.vim/undodir
set undofile

" adds vertical spaces to keep the text of the left and right pane aligned.
"diffopt=filler

" ignore whitespace
"diffopt+=iwhite

" Make it possible to use vim navigation keys in normal mode when russian kb layout is active
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.,ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

function! FormatXml()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    %!xmllint --format --encode utf8 --recover -
    " silent %!xmllint --format --encode utf8 --recover -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
    endfunction
noremap <F6> :call FormatXml()<CR>

" Toggles line numbering (relativenumber & number)
function! ToggleLineNumbers()
    if &number == 1
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction
noremap <F2> :call ToggleLineNumbers()<CR>

" map <F7> <Esc>:%!json_xs -f json -t json-pretty<CR>
map <C-n> :NERDTreeToggle<CR>
" map <F5> :buffers<CR>:buffer<Space>

" Do not jump to next occurence on *
nnoremap * *N

" Enable search highlight
" set hlsearch

" enable incremental search
set incsearch

" Next window with Tab key
" nmap <Tab> <C-w>w
" Previous window with Shift-Tab key
" nmap <S-Tab> <C-w>W

command! MakeTags !ctags -R --exclude='**/node_modules' --exclude='**/build' .

nmap <F8> :TagbarToggle<CR>

autocmd FileType xml map <F10> :%!envsubst<CR>
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

autocmd FileType Makefile noexpandtab

autocmd FileType groovy set tags+=/home/apechinsky/ctags/libs/java-libs.tags,/home/apechinsky/ctags/libs/jdk-1.8.0.tags
autocmd FileType groovy set colorcolumn=80,130
autocmd FileType groovy highlight ColorColumn ctermbg=darkgray
autocmd FileType groovy map <F10> :w<CR>:!groovy %<CR>
autocmd FileType groovy set suffixesadd=.groovy,.java

autocmd FileType java set tags+=/home/apechinsky/ctags/libs/java-libs.tags,/home/apechinsky/ctags/libs/jdk-1.8.0.tags
autocmd FileType java set colorcolumn=80,130
autocmd FileType java highlight ColorColumn ctermbg=darkgray
autocmd FileType java set suffixesadd=.java

autocmd Filetype java set makeprg=javac\ %
autocmd FileType java map <F9> :w<CR>:make<CR>
autocmd FileType java map <F10> :wall<CR>:make<CR>:!java %:r<CR>

autocmd Filetype kotlin set makeprg=kotlinc\ %
autocmd FileType kotlin map <F9> :w<CR>:make<CR>
autocmd FileType kotlin map <F10> :wall<CR>:make<CR>:!kotlin %:r<CR>
autocmd FileType kotlin set suffixesadd=.kt

autocmd Filetype javascript set makeprg=node\ %
autocmd FileType javascript map <F9> :wall<CR>:!node %<CR>
autocmd FileType javascript map <F10> :wall<CR>:!node %<CR>
autocmd FileType javascript set suffixesadd=.js,.ts

autocmd FileType python map <F9> :wall<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType sh map <F10> :w<CR>:!./%<CR>
autocmd FileType sh map <F10> :w<CR>:!bash %<CR>

autocmd FileType awk map <F10> :w<CR>:!awk -f %<CR>

autocmd FileType yaml set tabstop=2
autocmd FileType yaml set shiftwidth=2
autocmd FileType yaml set suffixesadd+=.yml,.yaml

autocmd FileType asciidoc map <F10> :wall<CR>:!asciidoctorj --require asciidoctor-diagram %<CR>
autocmd FileType asciidoc set textwidth=80

autocmd FileType swift set suffixesadd+=.swift,.m,.h
autocmd FileType kt set suffixesadd+=.kt

autocmd FileType typescriptreact set suffixesadd+=.tsx

" set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
" map <F9> :make<Return>:copen<Return>
" map <F10> :cprevious<Return>
" map <F11> :cnext<Return>

inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

" START vim wiki configuration
let wiki_personal = {}
let wiki_personal.path = '~/Dropbox/vimwiki/personal'
let wiki_personal.path_html = '~/Dropbox/vimwiki/personal/html'
let wiki_personal.syntax = 'markdown'
let wiki_personal.ext = '.md'

let wiki_work = {}
let wiki_work.path = '~/Dropbox/vimwiki/work'
let wiki_work.path_html = '~/Dropbox/vimwiki/work/html'
let wiki_work.syntax = 'markdown'
let wiki_work.ext = '.md'

let g:vimwiki_list = [wiki_work, wiki_personal]
" END vim wiki configuration

" ALE (language server plugin) configuration
" let g:ale_java_eclipselsp_path = '$HOME/opt/eclipse.jdt.ls'

" Fuzzy Finder configuration
noremap <Leader>f :FZF<CR>
let g:fzf_layout = { 'down': '40%' }

let g:snipMate = { 'snippet_version': 1}
" Custom snippets '$HOME/.vim/after/snippets' override standard
let g:snipMate.override = 1

" Disable modifyOtherKeys mode to prevent '>4;2m' characters in terminal " (e.g. ':!ls')
let &t_TI = ""
let &t_TE = ""

function SwapBool ()
  let s:w = expand("<cword>")

  if s:w == "false"
    normal ciwtrue
    if expand("<cword>") != "true"
      normal u
    endif
  elseif s:w == "true"
    normal ciwfalse
    if expand("<cword>") != "false"
      normal u
    endif
  endif
endfunction
noremap <leader>s :call SwapBool()<CR>

" "trans" integration plugin config
let g:trans_default_direction = ":ru"
noremap <Leader>t :Trans<CR>

""" ALE configuration

highlight RedundantSpaces ctermbg=red guibg=red 
match RedundantSpaces /\s\+$/

highlight ALEWarning ctermbg=DarkMagenta
highlight ALEError ctermbg=Red
" highlight ALEErrorSign
" highlight ALEWarningSign

let g:ale_linters = {
\   'java': ['checkstyle', 'eclipselsp', 'javac', 'javalsp', 'pmd'],
\   'javascript': ['eslint'],
\   'python': ['flake8', 'mypy'],
\   'asciidoc': ['alex', 'writegood'],
\   'markdown': ['alex', 'writegood'],
\   'vimwiki': ['alex', 'writegood'],
\   'bash': ['bashate', 'language_server', 'shell', 'shellcheck'],
\   'sh': ['bashate', 'language_server', 'shell', 'shellcheck'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['black', 'autoimport', 'autoflake', 'isort'],
\}

" let g:lsc_server_commands = {'java': '/home/apechinsky/.vim/java-language-server/dist/lang_server_linux.sh'}

