return {
    {
        -- Indentation line
        -- NOTE: Underline fix discussion
        -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/686
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            indent = {
                -- char = "▏",
                highlight = "IblChar",
            },
            scope = {
                -- char = "▏",
                highlight = "IblScopeChar",
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        -- Surround motion
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        opts = {},
    },
    {
        -- Auto update indentation size
        "NMAC427/guess-indent.nvim",
        opts = {},
        event = "BufReadPost",
    },
    {
        -- Highlight todo, notes etc. comments
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- NOTE: fix color after auto-session restore
            -- possible fix https://nvchad.com/docs/config/theming
            require("base46").load_all_highlights()
            -- dofile(vim.g.base46_cache .. "todo")
            require("todo-comments").setup({ signs = false })
        end,
        event = "BufReadPost",
    },
    {
        -- Type j without delay due to jj or jk
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        enabled = false,
        opts = {},
    },
    {
        -- Auto save :ASToggle
        "Pocco81/auto-save.nvim",
        event = "BufReadPost",
        enabled = not require("custom.path").is_config(),
        opts = {
            enabled = true,
            execution_message = {
                message = function()
                    return "Autosave " .. vim.fn.expand("%")
                end,
                cleaning_interval = 3000,
            },
        },
    },
}
