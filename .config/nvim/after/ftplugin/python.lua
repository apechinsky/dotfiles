vim.api.nvim_buf_set_keymap(0, 'n', '<F10>', ':wall<CR>:!python %<CR>', { noremap = true })


-- configure Debug Adapter (DAP)
local dap = require('dap')
dap.adapters.python = {
    type = 'executable',
    command = 'debugpy-adapter',
}

-- configure launch configuration
dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Global launch configuration",
        program = "${file}",
        -- pythonPath = function()
        --     return '/usr/bin/python'
        -- end,
    },
}
-- load local launch configuration from local file
require('dap.ext.vscode').load_launchjs(".vscode/launch.json")
