return {
    'rcarriga/nvim-notify',

    config = function()
        require('notify').setup({
            stages = 'fade_in_slide_out',
            timeout = 3000,
            top_down = false,
        })
        vim.notify = require("notify")
    end
}
