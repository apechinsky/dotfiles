if 1
    fun! ProfileStart()
        let profile_file = '/tmp/vim.'.getpid().'.profile.txt'
        echom "Profiling into" profile_file
        exec 'profile start '.profile_file
        profile! file **
        profile  func *
    endfun
    if get(g:, 'profile')
        call ProfileStart()
    endif
endif

" START Vandle configuration
set nocompatible
filetype off  

set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"репозитории на github
Plugin 'scrooloose/nerdtree'
Plugin 'will133/vim-dirdiff'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/tComment'
" Plugin 'tpope/vim-commentary'
Plugin 'majutsushi/tagbar'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vimwiki/vimwiki'

" Snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'

" Plugin 'Valloric/YouCompleteMe'

""" Color management plugins
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'
" Color schemes
Plugin 'morhetz/gruvbox'
Plugin 'jnurmine/Zenburn'
Plugin 'tomasiser/vim-code-dark'
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'jansenfuller/crayon'

"репозитории vim/scripts
Plugin 'L9'
Plugin 'FuzzyFinder'

Plugin 'matchit.zip'

Plugin 'apechinsky/vim-platform-io'

" Mirror of official vim Swift support
Plugin 'bumaociyuan/vim-swift'

"git репозитории (не на github)
"Plugin 'git://git.wincent.com/command-t.git'

"локальные git репозитории(если работаете над собственным плагином)
"Plugin 'file:///Users/gmarik/path/to/plugin'
"
call vundle#end()
" END Vandle configuration

filetype plugin indent on

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
" let g:gruvbox_termcolors=256
set background=dark

" Status line
set statusline=%f\ %m\ %r\ line:%l/%L[%p%%]\ col:%v\ buf:#%n\ char:%b[0x%B]

" adds vertical spaces to keep the text of the left and right pane aligned.
"diffopt=filler

" ignore whitespace
"diffopt+=iwhite

command! Ctags !ctags -R .

filetype plugin on

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
    silent %!xmllint --format --encode utf8 --recover - 
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

map <F2> <Esc>:'<,'>!xmllint --format --recover -<CR>
map <F6> <Esc>:FormatXml<CR>
" map <F7> <Esc>:%!json_xs -f json -t json-pretty<CR>
" map <F9> <Esc>:set number<CR>
" map <F10> <Esc>:set nonumber<CR>
map <C-n> :NERDTreeToggle<CR>
" map <F5> :buffers<CR>:buffer<Space>

" Do not jump to next occurence on *
nnoremap * *N
nnoremap <C-F8> :set hlsearch<CR>

" Next window with Tab key
" nmap <Tab> <C-w>w
" Previous window with Shift-Tab key
" nmap <S-Tab> <C-w>W

command! MakeTags !ctags -R .

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

autocmd FileType asciidoc map <F10> :wall<CR>:!asciidoctorj --require asciidoctor-diagram %<CR>

" set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
" map <F9> :make<Return>:copen<Return>
" map <F10> :cprevious<Return>
" map <F11> :cnext<Return>

inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

" Vim wiki

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

let g:vimwiki_list = [wiki_personal, wiki_work]

