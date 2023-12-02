return {
    'mfussenegger/nvim-dap',

    init = function ()
        local bufopts = { noremap = true, silent = true }
        require('anton.keymaps').dap_keymap(require('dap'), bufopts)
    end
}
