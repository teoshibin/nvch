return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        keys = "<leader>gg",
        config = function()
            dofile(vim.g.base46_cache .. "git")
            require("neogit").setup({})
            require("mappings").neogit()
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
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
