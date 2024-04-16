return {
    {
        -- :VimBeGood
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    },
    {
        -- :CellularAutomaton make_it_rain
        -- :CellularAutomaton game_of_life
        "eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },
    {
        -- gx for opening url as netrw got disabled by nvchad
        "chrishrb/gx.nvim",
        keys = {
            { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            handler_options = {
                search_engine = "google",
            },
        },
    },
    {
        -- peek line using :<number> without jumping to it
        "nacro90/numb.nvim",
        opts = {},
        event = "BufReadPost",
    },
    {
        "mbbill/undotree",
    },
    -- FIX: auto session
    -- {
    --  "rmagatti/auto-session",
    --  lazy = false,
    --  config = function()
    --   require("auto-session").setup({
    --    log_level = "error",
    --    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    --   })
    --  end,
    -- },
    -- {
    --   -- TODO: https://github.com/smoka7/multicursors.nvim?tab=readme-ov-file
    --
    --   "smoka7/multicursors.nvim",
    --   event = "VeryLazy",
    --   dependencies = {
    --     "smoka7/hydra.nvim",
    --   },
    --   opts = {},
    --   cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    --   keys = {
    --     {
    --       mode = { "v", "n" },
    --       "<Leader>m",
    --       "<cmd>MCstart<cr>",
    --       desc = "Create a selection for selected text or word under the cursor",
    --     },
    --   },
    -- },
}
