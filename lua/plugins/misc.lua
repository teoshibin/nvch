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
    {
        "rmagatti/auto-session",
        -- NOTE: lazy.nvim ui fix https://github.com/rmagatti/auto-session/issues/223
        init = function()
            local function restore()
                if vim.fn.argc(-1) > 0 then
                    return
                end

                vim.schedule(function()
                    require("auto-session").AutoRestoreSession()
                end)
            end

            local lazy_view_win = nil

            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    local lazy_view = require("lazy.view")

                    if lazy_view.visible() then
                        lazy_view_win = lazy_view.view.win
                    else
                        restore()
                    end
                end,
            })

            vim.api.nvim_create_autocmd("WinClosed", {
                callback = function(event)
                    if not lazy_view_win or event.match ~= tostring(lazy_view_win) then
                        return
                    end

                    restore()
                end,
            })
        end,
        opts = {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            pre_save_cmds = { "NvimTreeClose" },
        },
    },
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
