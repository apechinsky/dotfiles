require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",
        "awk_ls",
        "bashls",
        "cssls",
        "dockerls",
        "gradle_ls",
        "grammarly",
        "html",
        "jsonls",
        "tsserver",
        "sumneko_lua",
        "sqlls",
        "yamlls",
    }
})

require("mason-null-ls").setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,

    -- Recommended, but optional
    automatic_setup = true,
})

require("null-ls").setup({
    debug = true,
    sources = {
        -- Anything not supported by mason.
    }
})

require('mason-null-ls').setup_handlers()
