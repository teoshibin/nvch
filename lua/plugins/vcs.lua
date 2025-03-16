return {
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        keys = "<leader>gs",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "sindrets/diffview.nvim",
                keys = { "<leader>gd", "<leader>gl" },
                cmd = {
                    "DiffviewClose",
                    "DiffviewOpen",
                    "DiffviewFileHistory",
                    "DiffviewFocusFiles",
                    "DiffviewLog",
                    "DiffviewRefresh",
                    "DiffviewToggleFiles",
                },
                config = function(_, opts)
                    dofile(vim.g.base46_cache .. "git")
                    require("diffview").setup(opts)
                    require('mappings').diffview()
                    dofile(vim.g.base46_cache .. "git")
                end
            },
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            dofile(vim.g.base46_cache .. "git")
            require("neogit").setup({})
            require("mappings").neogit()
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        cmd = { "Gitsigns" },
        opts = function()
            local defaults = require("nvchad.configs.gitsigns")
            local configs = {
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 500,
                },
                on_attach = function(buffer)
                    require("mappings").gitsigns(buffer)
                end,
            }
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
}
