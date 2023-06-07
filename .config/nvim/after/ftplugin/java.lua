local utils = require('anton.utils')
local jdtls = require("jdtls")
local HOME = os.getenv('HOME')

local function getProjectNameFromSettingsGradle(settingsFile)
    if vim.fn.filereadable(settingsFile) ~= 0 then
        return utils.getProperty(settingsFile, 'rootProject.name')
    end
end

local function getProjectName(rootDir)
    local projectName = getProjectNameFromSettingsGradle(rootDir .. '/settings.gradle')

    if projectName ~= nil then
        return projectName
    end

    return vim.fn.fnamemodify(rootDir, ':p:h:t')
end

-- Return workspace directory
--  Should be unique per project
--  Should not be within project root
local function getWorkspaceDir(projectName)
    return xdg.data('jdtls/' .. projectName)
end

local function findBuildSystemRoot()
    return jdtls.setup.find_root({ "mvnw", "gradlew" })
end

local function getCurrentFileDir()
    return vim.fn.expand('%:p:h')
end

vim.opt_local.suffixes:append({ '.java' })

vim.opt_local.makeprg = 'javac %'

vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':wall<CR>:make<CR>', { noremap = true })

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!jbang %<CR>', { noremap = true })

vim.opt_local.tags:append({
    HOME .. "/ctags/libs/java-libs.tags",
    HOME .. "/ctags/libs/jdk-1.8.0.tags"
})

vim.opt_local.colorcolumn = { 80, 130 }

-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = red })
vim.cmd("highlight ColorColumn ctermbg=darkgray")

-- Java Language Server configuration.
local jdtls_home = xdg.data('mason/packages/jdtls')

local root_dir = findBuildSystemRoot() or getCurrentFileDir()
local project_name = getProjectName(root_dir)
local workspace_dir = getWorkspaceDir(project_name)

-- print("root_dir: " .. root_dir)
-- print("project_name: " .. project_name)
-- print("workspace_dir: " .. workspace_dir)

vim.diagnostic.enable()

-- is this needed???
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    --
    cmd = {
        HOME .. '/opt/jdk-17/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. xdg.subpath(jdtls_home, 'lombok.jar'),
        '-Xms1g',
        -- '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        -- '-jar', vim.fn.glob(jdtls_home .. '/plugins/org.eclipse.equinox.launcher_*.jar')
        -- '-jar',  xdg.subpath(jdtls_home, 'plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-jar',  vim.fn.glob(xdg.subpath(jdtls_home, 'plugins/org.eclipse.equinox.launcher_*.jar')),
        '-configuration', xdg.subpath(jdtls_home, "config_linux"),
        '-data', workspace_dir,
    },

    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            home = HOME .. '/opt/jdk-17',
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-19",
                        path = HOME .. "/opt/jdk-19",
                    },
                    {
                        name = "JavaSE-18",
                        path = HOME .. "/opt/jdk-18",
                    },
                    {
                        name = "JavaSE-17",
                        path = HOME .. "/opt/jdk-17",
                    },
                    {
                        name = "JavaSE-11",
                        path = HOME .. "/opt/jdk-11",
                    }
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    -- url = vim.fn.stdpath("config") .. "/tools/intellij-java-google-style.xml",
                    url = xdg.config('/tools/eclipse-java-google-style.xml'),
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                    "org.slf4j.Logger",
                    "org.slf4j.LoggerFactory",
                    "org.srplib.contract.Argument",
                    "org.srplib.contract.Assert"
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                    "net",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className} [${member.name()}: ${member.value}, ${otherMembers}]",
                },
                useBlocks = true,
            },
        },
        -- not sure this is needed
        -- capabilities = capabilities,
        -- not sure this is needed
        -- extendedClientCapabilities = extendedClientCapabilities,
    },

    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = {},
    },
}

config.on_attach = function(client, bufnr)
    jdtls.setup.add_commands()

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    require('anton.keymaps').lsp_keymap(bufopts)

  -- jdtls extension keymep
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, { desc = "Organize imports" } )
    vim.keymap.set("n", "<leader>vc", jdtls.test_class, { desc = "Test class (DAP)" } )
    vim.keymap.set("n", "<leader>vm", jdtls.test_nearest_method, { desc = "Test method (DAP)"})
    vim.keymap.set("n", "<leader>ev", jdtls.extract_variable, { desc = "Extract variable"})
    vim.keymap.set("n", "<leader>ec", jdtls.extract_constant, { desc = "Extract constant"})
    vim.keymap.set("v", "<leader>em", function() 
        jdtls.extract_method(true)
    end, { desc = "Extract method" })

    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window_above_cur_line = false,
        padding = '',
        handler_opts = {
            border = "rounded"
        }
    }, bufnr)
end

jdtls.start_or_attach(config)

