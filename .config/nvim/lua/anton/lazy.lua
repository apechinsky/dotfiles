-- 'Lazy' plugin manager configuration

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    git = {
        timeout = 180
    },
    spec = {
        { import = 'anton/plugins' },
        { import = "anton.plugins.lsp" }
    },
    checker = {
        enabled = false
    },

    -- Try to solve problem with spell language download problem
    -- this solution restores /site to RTP
    -- see details: https://github.com/neovim/neovim/issues/7189
    -- performance = {
    --     rtp = {
    --         paths = { vim.fn.stdpath("data") .. "/site" }
    --     }
    -- }
})
