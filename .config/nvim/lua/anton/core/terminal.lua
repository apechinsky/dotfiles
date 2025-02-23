--
-- Floating terminal window
--
--

M = {}

local function create_floating_window(opts)
    opts = opts or {}

    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        style = "minimal",
        relative = "editor",
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        width = width,
        height = height,
        border = "rounded"
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

M.toggle_terminal = function()
    if vim.api.nvim_win_is_valid(state.floating.win) then
        vim.api.nvim_win_hide(state.floating.win)
    else
        state.floating = create_floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    end
end

M.open_terminal = function()
    vim.cmd.split()
    vim.cmd.term()
    vim.api.nvim_win_set_height(0, 15)
end

vim.api.nvim_create_user_command('Terminal', M.toggle_terminal, {})
vim.api.nvim_create_user_command('NewTerminal', M.open_terminal, {})

return M

