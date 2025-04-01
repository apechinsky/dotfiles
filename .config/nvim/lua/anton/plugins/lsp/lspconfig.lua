return {
    'neovim/nvim-lspconfig',

    init = function()
        vim.api.nvim_create_autocmd('FileType', {

            pattern = 'structurizr',

            callback = function(ev)
                vim.lsp.start({
                    name = 'c4-dsl-language-server',
                    cmd = {
                        os.getenv('HOME') .. '/opt/c4-language-server/bin/c4-language-server',
                    },
                    cmd_env = {
                        JAVA_OPTS = '-Dlogback.configurationFile=' .. os.getenv('HOME') .. '/.config/c4-language-server/logback.xml'
                    },

                    -- Set the "root directory" to the parent directory of the file in the
                    -- current buffer (`ev.buf`) that contains either a "setup.py" or a
                    -- "pyproject.toml" file. Files that share a root directory will reuse
                    -- the connection to the same LSP server.
                    root_dir = vim.fs.root(ev.buf, { 'workspace.dsl' }),
                })
            end,
        })
    end
}
