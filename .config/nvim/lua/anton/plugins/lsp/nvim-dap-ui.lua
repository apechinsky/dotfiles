-- Debugger UI
return {
    "rcarriga/nvim-dap-ui",

    dependencies = {
        "mfussenegger/nvim-dap",
    },

    opts = {
    },

    init = function()
        local bufopts = { noremap = true, silent = true }
        require('anton.keymaps').dapui_keymap(require('dapui'), bufopts)
    end
}
