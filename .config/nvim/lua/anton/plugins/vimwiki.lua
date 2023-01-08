vim.api.nvim_exec([[

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

]],
true)
