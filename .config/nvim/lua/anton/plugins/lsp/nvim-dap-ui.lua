-- Debugger UI
return {
    "rcarriga/nvim-dap-ui",

    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },

    opts = {
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.75 },
                    { id = "watches", size = 0.25 },
                    { id = "repl", size = 0.25 },
                    -- { id = "breakpoints", size = 0.25 },
                    -- { id = "stacks", size = 0.25 },
                },
                position = "right",
                size = 40
            },
            {
                elements = {
                    { id = "console", size = 1 }
                },
                position = "bottom",
                size = 10
            },
        },
    },

    init = function()
        local bufopts = { noremap = true, silent = true }
        require('anton.keymaps').dapui_keymap(require('dapui'), bufopts)
    end


}
