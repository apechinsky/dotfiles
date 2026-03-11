return {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        ignore_warnings = true,
        opts = {
            log_level = "TRACE",
        },
        interactions = {
            chat = {
                adapter = "claude_code",
            },
            inline = {
                adapter = "claude_code",
            },
            cmd = {
                adapter = "claude_code",
            }
        },
        adapters = {
            acp = {
                claude_code = function()
                    return require("codecompanion.adapters").extend("claude_code", {
                        env = {
                            CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_TOKEN"),
                            HTTPS_PROXY = "http://" .. os.getenv("DO_PROXY"),
                        },
                    })
                end,
            },
            -- http = {
            --     opts = {
            --         allow_insecure = true,
            --         proxy = "http://" .. os.getenv("DO_PROXY"),
            --     },
            -- },
        },
        memory = {
            claude = {
                description = "Memory files for Claude Code users",
                files = {
                    "~/.claude/CLAUDE.md",
                    "CLAUDE.md",
                },
            },
        },
        extensions = {
            -- mcphub = {
            --     callback = "mcphub.extensions.codecompanion",
            --     opts = {
            --         make_vars = true,
            --         make_slash_commands = true,
            --         show_result_in_chat = true
            --     }
            -- }
        }
    }
}
