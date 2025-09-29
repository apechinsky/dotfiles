return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false,
    enabled = false,
    opts = {
        -- @alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        -- provider = "copilot",
        -- auto_suggestions_provider = "copilot",
        --
        on_complete = function(param)
            -- vim.notify("on_complete", vim.log.levels.INFO, {})
            -- print(vim.inspect(param))
        end,

        debug = false,
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        providers = {
            claude = {
                endpoint = "https://api.anthropic.com",
                model = "claude-sonnet-4-20250514",
                api_key_name = 'ANTHROPIC_API_KEY',
                proxy = vim.fn.getenv('COPILOT_PROXY'),
                extra_request_body = {
                    temperature = 0,
                    max_tokens = 4096,
                },
            },
            copilot = {
                -- endpoint = 'http://cxekjmaz1wg0000qr4rggqzj3kcyyyyyb.oast.pro',
                proxy = 'http://' .. vim.fn.getenv('COPILOT_PROXY')
            },

            -- openai = {
            --     -- openai
            --     model = 'gpt-4o-mini',
            --     proxy =  'http://' .. vim.fn.getenv('COPILOT_PROXY')
            -- },

            openai = {
                -- groq
                endpoint = 'https://api.groq.com/openai/v1',
                model = 'gemma2-9b-it',
                -- model = 'gemma-7b-it',
                -- model = 'llama3-70b-8192',
                -- model = 'distil-whisper-large-v3-en',
                api_key_name = 'GROQ_API_KEY',

                timeout = 30000,

                extra_request_body = {
                    temperature = 1,
                    max_tokens = 2048,
                },
            },
        },

        hints = { enabled = false },
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

    init = function()
        -- local proxy = vim.fn.getenv('COPILOT_PROXY')
        -- if proxy ~= vim.NIL then
        --     vim.g.copilot_proxy = 'http://' .. proxy
        -- end
    end
}
