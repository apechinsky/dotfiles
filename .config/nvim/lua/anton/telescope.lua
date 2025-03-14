--
-- An alternative implementation for telescope.live_grep that allows specifying files.
--
-- Activate: require('anton.telescope').live_grep_file():
--
-- Use: In a prompt string add file as follows: 'search-string /*.lua'
--
-- Limitations: Solution is for 'ripgrep' search utility.
--

local M = {}

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values
local utils = require('anton.core.utils')

M.live_grep_file = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = finders.new_async_job {
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "/")
            local args = { "rg" }

            if pieces[1] then
                print("pieces[1]: " .. pieces[1])
                table.insert(args, "-e")
                table.insert(args, utils.trim(pieces[1], ' '))
            end

            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, utils.trim(pieces[2], ' '))
                print("pieces[2]: " .. pieces[2])
            end

            return utils.concat(
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
            )
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    }

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "Live grep files (e.g. /*.lua)",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require('telescope.sorters').empty(),
    }):find()
end

M.setup = function ()
end

return M
