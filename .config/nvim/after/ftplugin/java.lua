local HOME = os.getenv('HOME')
local utils = require('anton.core.utils')
local xdg = require("anton.core.xdg")
local jdtls = require("jdtls")
local mason = require('mason-registry')

vim.opt_local.colorcolumn = { 80, 130 }
vim.opt_local.suffixes:append({ '.java' })
vim.opt_local.makeprg = 'jbang %'
vim.opt_local.autowrite = true

vim.opt_local.tags:append({
    HOME .. "/ctags/libs/java-libs.tags",
    HOME .. "/ctags/libs/jdk-1.8.0.tags"
})

vim.cmd("highlight ColorColumn ctermbg=darkgray")


-- Return workspace directory
--  * Should be unique per project
--  * Should NOT be within project root
local function getWorkspaceDir(projectName)
    return xdg.data('jdtls/' .. projectName)
end

-- Java Language Server configuration.
local jdtls_home = mason.get_package('jdtls'):get_install_path()

local java_debug_adapter_home = mason.get_package('java-debug-adapter'):get_install_path()
local java_test_adapter_home = mason.get_package('java-test'):get_install_path()
local java_decompiler_home = mason.get_package('vscode-java-decompiler'):get_install_path()

local function getBundles(pattern)
    local files = utils.get_files(pattern)
    if #files == 0 then
       vim.notify("No bundles found with pattern '" .. pattern .. "'", vim.log.levels.WARN)
    end
    return files
end

local java_debug_adapter_libs =
    getBundles(utils.child(java_debug_adapter_home, 'extension/server/com.microsoft.java.debug.plugin-*.jar'))

local java_test_adapter_libs =
    getBundles(utils.child(java_test_adapter_home, 'extension/server/*.jar'))
java_test_adapter_libs = utils.filter(java_test_adapter_libs, {
    'runner-jar-with-dependencies.jar',
    'jacocoagent.jar'
})

local java_decompiler_libs =
    getBundles(utils.child(java_decompiler_home, 'server/*.jar'))


-- 2023-12-09 Experimental
local jbang_adapter_home = xdg.config('java/jbang-eclipse')
local jbang_adapter_libs =
    utils.get_files(utils.child(jbang_adapter_home, 'target/*.jar'))

local bundles = utils.concat(
    java_debug_adapter_libs,
    java_test_adapter_libs,
    java_decompiler_libs
    -- jbang_adapter_libs
)

local project = require('anton.java.gradle').find(utils.get_current_file())
    or require('anton.java.single-file-project').get(utils.get_current_file())

-- local root_dir = project:get_root_dir()

local workspace_dir = getWorkspaceDir(project:get_name())

-- TODO: enabling diagnostics here causes strange errors when navigating between java files
-- vim.diagnostic.enable()

-- is this needed???
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
--
local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

local config = {
    root_dir = project:get_root_dir(),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request

    flags = {
        allow_incremental_sync = true,
    },


    init_options = {
        extendedClientCapabilities = extendedClientCapabilities,
        bundles = bundles,
    },

    capabilities = capabilities,
}

-- The command that starts the language server
-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
config.cmd = {
    utils.child(HOME, 'opt/jdk-17/bin/java'),
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. vim.fn.glob(xdg.config('java/lombok-*.jar')),
    -- '-javaagent:' .. vim.fn.glob(xdg.config('java/springloaded-*.jar')),
    '-Xms4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob(utils.child(jdtls_home, 'plugins/org.eclipse.equinox.launcher_*.jar')),
    '-configuration', utils.child(jdtls_home, "config_linux"),
    '-data', workspace_dir,
}

config.settings = {

    -- see JavaConfiguration class
    java = {
        home = HOME .. '/opt/jdk-17',
        eclipse = {
            downloadSources = true,
        },
        configuration = {
            updateBuildConfiguration = "interactive",
            runtimes = {
                {
                    name = "JavaSE-11",
                    path = utils.child(HOME, "/opt/jdk-11"),
                },
                {
                    name = "JavaSE-17",
                    path = utils.child(HOME, "/opt/jdk-17"),
                },
                {
                    name = "JavaSE-18",
                    path = utils.child(HOME, "/opt/jdk-18"),
                },
                {
                    name = "JavaSE-19",
                    path = utils.child(HOME, "/opt/jdk-19"),
                },
                {
                    name = "JavaSE-21",
                    path = utils.child(HOME, "/opt/jdk-21"),
                },
                {
                    name = "JavaSE-22",
                    path = utils.child(HOME, "/opt/jdk-22"),
                },
            }
        },
        jdt = {
            ls = {
                lombokSupport = true,
            },
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
                url = xdg.config('/tools/eclipse-my.xml'),
                profile = "eclipse-my",
            },
        },
        trace = {
            server = 'verbose',
        },
        import = {
            gradle = {
                enabled = true,
            },
            maven = {
                enabled = true,
            },
            exclusions = {
                "**/node_modules/**",
                "**/.metadata/**",
                "**/archetype-resources/**",
                "**/META-INF/maven/**",
                "/**/test/**",
            },
        },
        signatureHelp = {
            enabled = true
        },
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
                "java", "#java",
                "javax", "#javax",
                "org", "#org",
                "net", "#net",
                "com", "#com",
                "by", "#by",
                "ru", "#ru",
                "", "#",
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
}

local function on_attach_delegate(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    require('anton.keymaps').lsp_keymap(bufopts)
    require('anton.keymaps').java_keymap(jdtls, bufopts)
end

config.on_attach = function(client, bufnr)
    local res, err = pcall(on_attach_delegate, client, bufnr)
    if not res then
        vim.notify("Error: " .. err)
    end
end


local dap = require('dap')

dap.configurations.java = {
    {
        type = 'java',
        request = 'launch',
        name = 'Debug (Attach)',
        hostName = 'localhost',
        port = 5005,
    },
}

jdtls.start_or_attach(config)

