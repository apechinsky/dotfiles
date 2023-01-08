-- disable mouse
vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 6

vim.opt.updatetime = 500

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme("habamax")
--vim.cmd.colorscheme("gruvbox")

vim.opt.cursorline = true
vim.opt.colorcolumn = "80,120"
vim.opt.signcolumn = "yes"

-- configure '-' as a part of 'word'
vim.opt.iskeyword:append("-")

vim.opt.path:append("**")

-- yank (copy/cut) to system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Make it possible to use vim navigation keys in normal mode when russian kb layout is active
vim.opt.langmap = "ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.,ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>"

vim.opt.wildignore:append("**/node_modules/**")

-- highlight tabs and trailing spaces
-- old config. There are two commands
-- command! WhitespaceAll set list listchars=eol:¬,tab:>·,trail:◦,extends:>,precedes:<,space:◦
-- command! WhitespaceTrail set list listchars=tab:>·,trail:◦
vim.cmd("set list listchars=tab:>·,trail:◦")

vim.opt.thesaurus:append(os.getenv("HOME") .. "/.config/nvim/thesaurus/thesaurus.txt")
