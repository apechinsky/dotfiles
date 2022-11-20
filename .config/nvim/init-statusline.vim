" Statusline configuraion

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
      \     [ 'gitbranch', 'readonly', 'relativepath', 'modified', 'char'] 
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ]
      \   ]
      \ },
      \ 'component': {
      \   'char': '%3b/%Bh',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
