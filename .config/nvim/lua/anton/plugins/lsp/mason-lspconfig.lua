-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Disable semantic tokens hightlighting since they interfere with treesitter groups
    client.server_capabilities.semanticTokensProvider = nil

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    require('anton.keymaps').lsp_keymap(bufopts)
end


--
local servers = {
    jdtls = {
        -- disable JDTLS LSP configuration via mason-lspconfig
        -- Mason is used just to install JDTLS
        -- JDTLS is configured manually (see java)
        disabled = true
    },

    kotlin_lsp = {
    },

    -- clangd = {
    -- },
    --
    pyright = {
    },

    lua_ls = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- telemetry = { enable = false },
            diagnostics = {
                globals = { 'vim' }
            },
            completion = {
                callSnippet = "Replace"
            }
        },
    },

    jsonls = {
        json = {
            -- Configuration according to schemastore.nvim
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },

    yamlls = {
        yaml = {
            -- schemastore.nvim recommended configuration (disable built-in schemaStore)
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
        }
    },

    groovyls = {
    },
}

return {
    'williamboman/mason-lspconfig.nvim',

    dependencies = {
        'williamboman/mason.nvim',
        'neovim/nvim-lspconfig',
        'saghen/blink.cmp',
    },

    opts = {
        ensure_installed = {
            "jdtls",
            "lua_ls",
            "bashls",
            "jsonls",
            "yamlls",
            "kotlin_lsp",
        },

        -- jdtls is started by nvim-jdtls (see after/ftplugin/java.lua)
        automatic_enable = {
            exclude = { 'jdtls' },
        },
    },

    -- mason-lspconfig v2 does not support 'handlers' anymore:
    -- servers are configured via vim.lsp.config() and enabled by mason-lspconfig
    config = function(_, opts)
        -- for blink-cmp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        vim.lsp.config('*', {
            capabilities = capabilities,
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
        })

        for server_name, settings in pairs(servers) do
            if not settings.disabled then
                vim.lsp.config(server_name, { settings = settings })
            end
        end

        vim.lsp.config('kotlin_lsp', {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                require('anton.keymaps').kotlin_keymap({ noremap = true, silent = true, buffer = bufnr })
            end,
        })

        require('mason-lspconfig').setup(opts)
    end,
}
