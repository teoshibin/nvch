return {
    {
        "nvim-tree/nvim-tree.lua",
        opts = function()
            local defaults = require("nvchad.configs.nvimtree")
            local configs = {
                filters = {
                    git_ignored = false,
                    custom = {
                        "^.git$",
                    },
                },
                renderer = {
                    icons = {
                        glyphs = {
                            git = {
                                unstaged = "",
                                staged = "",
                                unmerged = "",
                                renamed = "",
                                untracked = "",
                                deleted = "",
                                ignored = "",
                            },
                        },
                    },
                },
            }
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = function()
            local defaults = require("nvchad.configs.telescope")
            local configs = {
                extensions_list = { "harpoon" },
            }
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        -- Sticky line on top of the editor
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            max_lines = 3,
            multiline_threshold = 1,
        },
        event = "BufReadPost",
    },
    {
        -- File Navigation
        "ThePrimeagen/harpoon",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = false,
        opts = {},
    },
    {
        "dstein64/nvim-scrollview",
        event = "BufReadPost",
    },
}
