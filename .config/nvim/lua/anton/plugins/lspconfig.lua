-- LSP configuration

-- disable diagnostics by default
vim.diagnostic.disable()

-- See `:help vim.diagnostic.*` for documentation on any of the below functions


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>de', vim.diagnostic.enable, opts)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable, opts)
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    require('anton.keymaps').lsp_keymap(bufopts)
end


local servers = {
    jdtls = {
        disabled = true
    },
    awk_ls = {},
    bashls = {},
    cssls = {},
    dockerls = {},
    gradle_ls = {},
    groovyls = {},
    grammarly = {},
    html = {},
    jsonls = {},
    tsserver = {},
    sqlls = {},
    yamlls = {},
    pylsp = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            -- telemetry = { enable = false },
            diagnostics = {
                globals = { 'vim' }
            },
            completion = {
              callSnippet = "Replace"
            }
        },
    },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup()

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  -- ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        if servers[server_name] == null then
            print("Language server '" .. server_name .. "' is note defined in 'servers' collection. Skip.")
            return
        end
        if servers[server_name].disabled then
            return
        end
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            flags = {
                debounce_text_changes = 150,
            }
        };
    end,
}

require("mason-null-ls").setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,

    -- Recommended, but optional
    automatic_setup = true,
})

local null_ls = require("null-ls")

vim.lsp.set_log_level 'debug'

null_ls.setup({
    debug = true,

    sources = {
        -- Anything not supported by mason.

        null_ls.builtins.diagnostics.yamllint.with({
            extra_args = { "-c", xdg.tools('yamllint.yaml') }
        }),

        null_ls.builtins.formatting.yamlfmt.with({
            extra_args = { "--conf", xdg.tools('yamlfmt.yaml') }
        }),

        null_ls.builtins.formatting.jq.with({
            extra_args = { "--indent", 4 },
        }),

        null_ls.builtins.diagnostics.markdownlint.with({
            extra_args = { "--config", xdg.tools("markdownlint.yaml") },
        }),

        null_ls.builtins.formatting.xmllint.with({
        }),

        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "--indent", 4 },
        }),
    },
    on_attach = on_attach
})


