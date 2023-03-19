-- LSP configuration

-- Diagnostic mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>de', vim.diagnostic.enable, opts)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.disable, opts)
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>fm', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
end

local servers = {

    jdtls = {},
    awk_ls = {},
    bashls = {},
    cssls = {},
    dockerls = {},
    gradle_ls = {},
    grammarly = {},
    html = {},
    jsonls = {},
    tsserver = {},
    sqlls = {},
    yamlls = {},
    pylsp = {},

    sumneko_lua = {
        Lua = {
            -- workspace = { checkThirdParty = false },
            -- telemetry = { enable = false },
            diagnostics = {
                globals = { 'vim' }
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
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
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

null_ls.setup({
    debug = true,

    sources = {
        -- Anything not supported by mason.

        null_ls.builtins.diagnostics.yamllint.with({
            extra_args = { "-c", myconfig.tools('yamllint.yaml') }
        }),

        null_ls.builtins.diagnostics.markdownlint.with({
            extra_args = { "--config", myconfig.tools("markdownlint.yaml") },
        }),

        null_ls.builtins.formatting.xmllint.with({
        }),

        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "--indent", 4 },
        }),
    },
    on_attach = on_attach
})

require('mason-null-ls').setup_handlers()
