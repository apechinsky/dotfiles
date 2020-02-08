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

" Fuzzy finder. After installation FZF will be available from command line also. 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Directory tree explorer plugin for vim (Ctrl-N)
Plug 'scrooloose/nerdtree'

" vimdiff for directories
Plug 'will133/vim-dirdiff'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Plug 'vim-scripts/tComment'
Plug 'tpope/vim-commentary'
"
Plug 'majutsushi/tagbar'

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

" Color schemes switcher (F8, Shift-F8)
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'tomasiser/vim-code-dark'
Plug 'danilo-augusto/vim-afterglow'

" platformio support (leader-c - compile, leader-d - compile&deploy)
Plug 'apechinsky/vim-platform-io'

" Swift language support
Plug 'bumaociyuan/vim-swift'

" Javascript plugin
Plug 'pangloss/vim-javascript' 

" Vim-script library, which provides some utility functions and commands for programming in Vim.
Plug 'vim-scripts/L9'

Plug 'vim-scripts/matchit.zip'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support 
Plug 'dense-analysis/ale'

call plug#end()
" END vim-plug configuration

" Terminal encoding
set termencoding=utf-8

" File encodings and detection order
set fileencodings=utf8,cp1251

" Enable line numbers
set number

" Disable backup files creation
set nobackup

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

" set textwidth=100

set pastetoggle=<F5>

" Show cursor position
set ruler

" Enable incremental search
set incsearch

" Ignore case if search string is in lowercase. Otherwise use case sensitive search.
set ignorecase smartcase

" Allow to put/get yanked text to system clipboard (unnamedplus) or X11-selection (unnamed)
" Check Vim xterm_clipboard option with (vim --version). If no option, install vim-gtk package
set clipboard=unnamedplus
" Prevent clipboard from being cleared on exit
autocmd VimLeave * call system("xclip -o -sel clip | xclip -sel clip")

" colorscheme torte
colorscheme gruvbox
" colorscheme zenburn
let g:gruvbox_termcolors=256
set background=dark

""" Status line
" Always show status line
set laststatus=2
" status format
set statusline=%f\ %m\ %y\ %r\ line:%l/%L[%p%%]\ col:%v\ buf:#%n\ char:%b[0x%B]

" adds vertical spaces to keep the text of the left and right pane aligned.
"diffopt=filler

" ignore whitespace
"diffopt+=iwhite

command! Ctags !ctags -R .


" Make it possible to use vim navigation keys in normal mode when russian kb layout is active
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.,ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

function! DoPrettyXML()
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
command! FormatXml call DoPrettyXML()

map <F2> <Esc>:'<,'>!xmllint --format --recover --noent - \| sed 1d<CR>
map <F6> <Esc>:FormatXml<CR>
" map <F7> <Esc>:%!json_xs -f json -t json-pretty<CR>
" map <F9> <Esc>:set number<CR>
" map <F10> <Esc>:set nonumber<CR>
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

command! MakeTags !ctags -R .

autocmd FileType xml map <F10> :%!envsubst<CR>`^
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

autocmd FileType Makefile noexpandtab

autocmd FileType groovy set tags+=/home/apechinsky/ctags/libs/java-libs.tags,/home/apechinsky/ctags/libs/jdk-1.8.0.tags
autocmd FileType groovy set colorcolumn=130
autocmd FileType groovy highlight ColorColumn ctermbg=darkgray
autocmd FileType groovy map <F10> :w<CR>:!groovy %<CR>

autocmd FileType java set tags+=/home/apechinsky/ctags/libs/java-libs.tags,/home/apechinsky/ctags/libs/jdk-1.8.0.tags
autocmd FileType java set colorcolumn=130
autocmd FileType java highlight ColorColumn ctermbg=darkgray

autocmd Filetype java set makeprg=javac\ %
autocmd FileType java map <F9> :w<CR>:make<CR>
autocmd FileType java map <F10> :wall<CR>:make<CR>:!java %:r<CR>

autocmd FileType sh map <F10> :w<CR>:!./%<CR>
autocmd FileType sh map <F10> :w<CR>:!bash %<CR>

autocmd FileType awk map <F10> :w<CR>:!awk -f %<CR>

" autocmd FileType yml set suffixesadd+=.yml
" autocmd FileType yml set set tabstop=2
" autocmd FileType yml set set shiftwidth=2

autocmd FileType asciidoc map <F10> :wall<CR>:!asciidoctorj --require asciidoctor-diagram %<CR>

autocmd FileType swift set suffixesadd+=.swift,.m,.h

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

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" ALE configuration
let g:ale_java_eclipselsp_path = '/home/apechinsky/opt/eclipse.jdt.ls'
let g:ale_java_eclipselsp_path = '$HOME/opt/eclipse.jdt.ls'

noremap ff :FZF<CR>
