return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    opts = {
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
        native_servers = {
            weather = require('anton.mcp.weather')
        }
    }
    -- config = function()
    --     require("mcphub").setup()
    -- end
}
