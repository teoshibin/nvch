return {
    {
        -- workspace file rename with imports
        -- integrated with nvim-tree
        "antosha417/nvim-lsp-file-operations",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
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
        event = "User FilePost",
        config = function()
            require("harpoon").setup({})
            require("mappings").harpoon()
        end,
    },
    {
        "dstein64/nvim-scrollview",
        event = "BufReadPost",
    },
    {
        -- extra ui, file rename, select option
        "stevearc/dressing.nvim",
        lazy = false,
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = "<leader>z",
        config = function(opts)
            require("zen-mode").setup(opts)
            require("mappings").zenMode()
        end
    },
}
