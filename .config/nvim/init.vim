if empty(glob(stdpath('config') . '/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug. Configuration
call plug#begin(stdpath('config') . '/plugged')

" groovbox colorscheme
Plug 'morhetz/gruvbox'
 
" Plug 'vim-scripts/tComment'
Plug 'tpope/vim-commentary'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-surround'

" LSP configuration 
Plug 'neovim/nvim-lspconfig'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support 
Plug 'dense-analysis/ale'

" LS installer
Plug 'williamboman/nvim-lsp-installer'

" Statusline configurer (via g:lightline variable)
Plug 'itchyny/lightline.vim'

" Colorize CSS-style color definitions (e.g. #705, #000077)
Plug 'ap/vim-css-color'

" ???. Required by telescope
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
" Disabled since causes an error
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Telescope fuzzy finder plugin (requires: plenary, nvim-treesitter)
Plug 'nvim-telescope/telescope.nvim'

" Fuzzy finder.  
" Method 1. Install fzf viz vim plugin
" After installation FZF will be available from command line also.
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Method 2. Install fzf externally and declare plugin
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" ctags bar
Plug 'preservim/tagbar'

" Personal Wiki for Vim http://vimwiki.github.io/
Plug 'vimwiki/vimwiki'

" Translate shell integration
Plug 'echuraev/translate-shell.vim'

" icons (required by nvim-tree)
Plug 'kyazdani42/nvim-web-devicons'

" nvim-tree plugin (requires nvim-web-devicons)
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

set path+=**

" Enable line numbers
set number

" Enable relative numbers
set relativenumber

set nobackup
set noswapfile

" Create undodir
let $undoDir = stdpath("data") . "/undodir"
call mkdir($undoDir, "p", 0700)
set undodir=$undoDir
set undofile

" Set tabulation
set expandtab
set tabstop=4
set shiftwidth=4
set nohlsearch

set splitright

" Disable line wrapping
set nowrap

set hidden

set splitright

set scrolloff=6

" Do not jump to next occurence on *
nnoremap * *N

" Ignore case if search string is in lowercase. Otherwise use case sensitive search.
set ignorecase smartcase

" Allow to put/get yanked text to system clipboard (unnamedplus) or X11-selection (unnamed)
" Check Vim xterm_clipboard option with (vim --version). If no option, install vim-gtk package
set clipboard=unnamedplus

set wildignore+=**/node_modules/**

" Enable spell highlighting with gruvbox theme
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
let g:gruvbox_termcolors=256
set background=dark

" Make it possible to use vim navigation keys in normal mode when russian kb layout is active
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.,ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

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
autocmd FileType kotlin set suffixesadd+=.kt

autocmd Filetype javascript set makeprg=node\ %
autocmd FileType javascript map <F9> :wall<CR>:!node %<CR>
autocmd FileType javascript map <F10> :wall<CR>:!node %<CR>
autocmd FileType javascript set suffixesadd=.js,.ts

autocmd Filetype typescript set makeprg=node\ %
autocmd FileType typescript map <F9> :wall<CR>:!node %<CR>
autocmd FileType typescript map <F10> :wall<CR>:!node %<CR>
autocmd FileType typescript set suffixesadd=.ts

autocmd FileType sh map <F10> :w<CR>:!./%<CR>
autocmd FileType sh map <F10> :w<CR>:!bash %<CR>
autocmd FileType sh set tabstop=4
autocmd FileType sh set shiftwidth=4

autocmd FileType awk map <F10> :w<CR>:!awk -f %<CR>

autocmd FileType yaml set suffixesadd+=.yml,.yaml
autocmd FileType yaml set tabstop=2
autocmd FileType yaml set shiftwidth=2

autocmd FileType asciidoc map <F10> :wall<CR>:!asciidoctorj --require asciidoctor-diagram %<CR>
autocmd FileType asciidoc set textwidth=80

autocmd FileType swift set suffixesadd+=.swift,.m,.h

autocmd FileType typescriptreact set suffixesadd+=.tsx

command! MakeTags !ctags -R --exclude=**/node_modules --exclude=**/build .
nmap <F8> :TagbarToggle<CR>

" Fuzzy Finder configuration
noremap <Leader>f :FZF<CR>
let g:fzf_layout = { 'down': '40%' }

" Trans plugin config
let g:trans_default_direction = ":ru"
noremap <Leader>d :Trans<CR>

tnoremap <Esc> <C-\><C-n>

source <sfile>:h/init-statusline.vim
source <sfile>:h/init-lsp.vim
source <sfile>:h/init-ale.vim
source <sfile>:h/init-treesitter.vim
source <sfile>:h/init-vimwiki.vim
source <sfile>:h/init-telescope.vim
source <sfile>:h/init-nvim-tree.vim
source <sfile>:h/init-functions.vim

" set list listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
WhitespaceTrail
