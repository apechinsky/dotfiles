return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    enabled = false,
    opts = {
        -- @alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = "copilot",
        auto_suggestions_provider = "copilot",

        openai = {
            proxy = vim.fn.getenv('COPILOT_PROXY')
        },
        copilot = {
            proxy = vim.fn.getenv('COPILOT_PROXY')
        }
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- --- The below dependencies are optional,
        -- "nvim-tree/nvim-web-devicons",
        -- "zbirenbaum/copilot.lua",  -- for providers='copilot'
        -- {
        --     -- support for image pasting
        --     "HakonHarnes/img-clip.nvim",
        --     event = "VeryLazy",
        --     opts = {
        --         -- recommended settings
        --         default = {
        --             embed_image_as_base64 = false,
        --             prompt_for_file_name = false,
        --             drag_and_drop = {
        --                 insert_mode = true,
        --             },
        --             -- required for Windows users
        --             use_absolute_path = true,
        --         },
        --     },
        -- },
        -- {
        --     -- Make sure to set this up properly if you have lazy=true
        --     'MeanderingProgrammer/render-markdown.nvim',
        --     opts = {
        --         file_types = { "markdown", "Avante" },
        --     },
        --     ft = { "markdown", "Avante" },
        -- },
    },

    init = function ()
        -- local proxy = vim.fn.getenv('COPILOT_PROXY')
        -- if proxy ~= vim.NIL then
        --     vim.g.copilot_proxy = 'http://' .. proxy
        -- end
    end
}
