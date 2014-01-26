" START Vandle configuration
set nocompatible
filetype off  

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

filetype plugin indent on
Bundle 'gmarik/vundle'

"репозитории на github
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/tComment'

" Snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'

"репозитории vim/scripts
Bundle 'L9'
Bundle 'FuzzyFinder'

Bundle 'matchit.zip'
Bundle 'vundle'

"git репозитории (не на github)
"Bundle 'git://git.wincent.com/command-t.git'

"локальные git репозитории(если работаете над собственным плагином)
"Bundle 'file:///Users/gmarik/path/to/plugin'
" END Vandle configuration


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

set autoindent

" Set tabulation
set expandtab
set tabstop=4
set shiftwidth=4

set pastetoggle=<F5>

" Show cursor position
set ruler

" Enable inclremental search
set incsearch

colorscheme torte

" Status line
set statusline=%f\ %m\ %r\ line:%l/%L[%p%%]\ col:%v\ buf:#%n\ char:%b[0x%B]

" adds vertical spaces to keep the text of the left and right pane aligned.
"diffopt=filler

" ignore whitespace
"diffopt+=iwhite

filetype plugin on

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Make it possible to use vim navigation keys in normal mode when russian kb layout is active
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.,ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

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

map <F2> <Esc>:1,$!xmllint --format --recover -<CR>
map <F12> <Esc>:FormatXml<CR>
map <F9> <Esc>:set number<CR>
map <F10> <Esc>:set nonumber<CR>

" Do not jump to next occurence on *
nnoremap * *N
nnoremap <C-F8> :hlsearch<CR>

