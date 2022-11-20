" My vim functions

command! WhitespaceAll set list listchars=eol:¬,tab:>·,trail:◦,extends:>,precedes:<,space:◦
command! WhitespaceTrail set list listchars=tab:>·,trail:◦

"
" Swap words true and false
"
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

"
" Format XML
"
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
    %!xmllint --format --encode utf-8 --recover - 
    " silent %!xmllint --format --encode utf8 --recover - 
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2"_d
    $"_d
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

