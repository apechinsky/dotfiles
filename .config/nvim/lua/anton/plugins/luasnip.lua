
-- load lua snippets
require("luasnip.loaders.from_lua").load({paths = "./mysnippets"})

-- load vs-code snippets from plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

-- load vs-code snippets relative to the directory of $MYVIMRC
require("luasnip.loaders.from_vscode").lazy_load({paths = "./mysnippets"})


