-- filetype specific configurations

vim.cmd([[
autocmd FileType Makefile noexpandtab

autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType lua map <F10> :wall<CR>:!lua %<CR>

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
" autocmd FileType java map <F10> :wall<CR>:make<CR>:!java %:r<CR>
autocmd FileType java map <F10> :w<CR>:!jbang %<CR>

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
]])
