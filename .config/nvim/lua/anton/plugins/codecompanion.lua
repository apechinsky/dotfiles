return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        opts = {
            log_level = "TRACE",
        },
        strategies = {
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
                            CLAUDE_CODE_OAUTH_TOKEN = "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",
                        },
                    })
                end,
            },
            http = {
                opts = {
                    allow_insecure = true,
                    proxy = "http://192.168.8.202:3128",
                },
            },
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
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    make_vars = true,
                    make_slash_commands = true,
                    show_result_in_chat = true
                }
            }
        }
    }
}
