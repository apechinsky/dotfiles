return {
    'rcarriga/nvim-notify',

    config = function()
        require('notify').setup({
            stages = 'fade_in_slide_out',
            timeout = 5000,
        })
        vim.notify = require("notify")
    end
}
