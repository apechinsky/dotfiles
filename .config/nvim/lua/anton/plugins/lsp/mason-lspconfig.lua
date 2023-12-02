-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    require('anton.keymaps').lsp_keymap(bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
local servers = {
    jdtls = {
        -- disable JDTLS LSP configuration via mason-lspconfig
        -- Mason is used just to install JDTLS
        -- JDTLS is configured manually (see java)
        disabled = true
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
}

return {
    'williamboman/mason-lspconfig.nvim',

    dependencies = {
        'williamboman/mason.nvim',
        'neovim/nvim-lspconfig',
    },

    opts = {
        ensure_installed = {
            "jdtls",
            "lua_ls",
            "bashls",
            "jsonls",
            "yamlls",
        },

        handlers = {
            function(server_name)
                if servers[server_name] ~= nil and servers[server_name].disabled then
                    return
                end

                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    flags = {
                        debounce_text_changes = 150,
                    }
                }
            end
        }
    }
}
