" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.Dockerfile setfiletype dockerfile
  au! BufRead,BufNewFile Dockerfile.* setfiletype dockerfile
augroup END
