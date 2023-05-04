local utils = require('anton.utils')

local function getProjectNameFromSettingsGradle(settingsFile)
    if vim.fn.filereadable(settings_file) then
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

local function prepareWorkspaceDir(rootDir)
    local workspaceDir = rootDir .. '/build/jdtls'
    os.execute("mkdir -p " .. workspaceDir)
    return workspaceDir
end

local function findRootDir()
    return require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
end

vim.opt_local.suffixes:append({ '.java' })

vim.opt_local.makeprg = 'javac %'

vim.api.nvim_buf_set_keymap(0, 'n', '<F9>', ':wall<CR>:make<CR>', { noremap = true })

-- vim.keymap.set('n', '<F10>', ":wall<CR>:make<CR>:!java %:r<CR>")
vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!jbang %<CR>', { noremap = true })

vim.opt_local.tags:append({
    "/home/apechinsky/ctags/libs/java-libs.tags",
    "/home/apechinsky/ctags/libs/jdk-1.8.0.tags"
})

vim.opt_local.colorcolumn = { 80, 130 }

-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = red })
vim.cmd("highlight ColorColumn ctermbg=darkgray")


-- Java Language Server configuration.

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
  return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
local path_to_lsp_server = jdtls_path .. "/config_linux"
local path_to_plugins = jdtls_path .. "/plugins/"
local path_to_jar = path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
local lombok_path = jdtls_path .. "/lombok.jar"
local root_dir = findRootDir()

if root_dir == nil then
  return
end

local project_name = getProjectName(root_dir)

local workspace_dir = prepareWorkspaceDir(root_dir)

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    --
  cmd = {
    '/home/apechinsky/opt/jdk-19/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. lombok_path,
    '-Xms1g',
    -- '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', path_to_jar,
    '-configuration', path_to_lsp_server,
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
      home = '/home/apechinsky/opt/jdk-17',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-19",
            path = "/home/apechinsky/opt/jdk-19",
          },
          {
            name = "JavaSE-18",
            path = "/home/apechinsky/opt/jdk-18",
          },
          {
            name = "JavaSE-17",
            path = "/home/apechinsky/opt/jdk-17",
          },
          {
            name = "JavaSE-11",
            path = "/home/apechinsky/opt/jdk-11",
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
          url = vim.fn.stdpath("config") .. "/tools/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
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
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
  },
}

config['on_attach'] = function(client, bufnr)
  require'keymaps'.map_java_keys(bufnr);
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window_above_cur_line = false,
    padding = '',
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)


