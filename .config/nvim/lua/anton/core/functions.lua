--
-- Swap words true and false. TODO: port to lua
--
vim.cmd([[
function! SwapBool ()
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
]])

--
-- Format XML. TODO: port to lua
--
vim.cmd([[
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
    1,2d_
    $d_
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
endfunction
]])

--
-- Toggle line numbers. TODO: port to lua
--
vim.cmd([[
function! ToggleLineNumbers()
    if &number == 1
        set nonumber
        set norelativenumber
    else
        set number
        set relativenumber
    endif
endfunction
]])

vim.cmd([[
function! ToggleRelativeLineNumbers()
    if &relativenumber == 1
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
]])

vim.cmd([[
function! MakeTags()
    ctags -R --exclude='**/node_modules' --exclude='**/build' .
endfunction
]])

function X509decode()
    vim.cmd([[
        :%!openssl x509 -text -nameopt=utf8 -inform PEM
    ]])
end
vim.api.nvim_create_user_command('X509decode', function(_) X509decode() end, {})

--
-- Parses out xml-rsponse and xml-request from Sring-ws log record, format
-- xml messages and copy them to separate buffers
-- log record format: '... Received response [xml-response] for request [xml-request]'
--
vim.cmd([[
command! WsLog :normal 0/Received response/<CR>:normal f[<CR>"byi[:normal f[<CR>"ayi[:new<CR>"ap<F6>GG0:new<CR>"bp<F6>GG0
]])

-- Not yet ready! An attempt to reproduce previous 'WsLog' command in Lua
function WsLogLua()
    vim.cmd('execute "0/Received response/\\<CR>"')
end
vim.api.nvim_create_user_command('WS', function(_) WsLogLua() end, {})

