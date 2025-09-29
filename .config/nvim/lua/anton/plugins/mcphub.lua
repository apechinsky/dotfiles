return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    opts = {
        config = vim.fn.expand("~/.config/mcphub/servers.json"),

        native_servers = {
            -- my vim-native MCP server example
            weather = require('anton.mcp.weather')
        },
        log = {
            level = vim.log.levels.DEBUG,
            to_file = false,
            file_path = nil,
            prefix = "MCPHub",
        },
        extensions = {
            avante = {
                make_slash_commands = true,
            }
        }
    },
    config = function()
        -- require("avante").setup({
        --     system_prompt = function()
        --         local hub = require("mcphub").get_hub_instance()
        --         return hub and hub:get_active_servers_prompt() or ""
        --     end,
        --     custom_tools = function()
        --         return {
        --             require("mcphub.extensions.avante").mcp_tool(),
        --         }
        --     end,
        -- })
    end
}
