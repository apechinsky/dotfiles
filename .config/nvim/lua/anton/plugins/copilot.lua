return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",

    enabled = true,

    opts = {
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = "<M-CR>",
                prev = "<M-[>",
                next = "<M-]>",
                dismiss = "<ESC>",
            },
        },
        panel = {
            enabled = true,
            auto_refresh = true,
            keymap = {
                jump_prev = "[[",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-p>"
            },
        },
    },

    init = function()
        local proxy = vim.fn.getenv('COPILOT_PROXY')
        if proxy ~= vim.NIL then
            vim.g.copilot_proxy = 'http://' .. proxy
        end
    end,
}
