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
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/brain",
                },
            },
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ["<leader>ic"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
                ["<leader>ia"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                },
            },
            ---@param title string|?
            ---@return string
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a date and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '2023-04-28_my-new-note.md'
                local os_date = os.date("*t") -- Get table with year, month, day etc.
                local formatted_date = string.format("%04d-%02d-%02d", os_date.year, os_date.month, os_date.day)

                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into a valid file name.
                    suffix = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower() -- improved regex to handle non-alphanumeric and whitespace correctly
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    math.randomseed(os.time()) -- Seed the random number generator to make it less predictable
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return formatted_date .. "_" .. suffix .. ".md"
            end,
            attachments = {
                img_folder = "assets/images",
            },
            templates = {
                subdir = "templates",
            },
        },
        -- config = function(_, opts)
        --     local client = require("obsidian").get_client()
        --     local map = require("mappings").map
        --     map("n", "<leader>in", function()
        --         local title = 
        --         client.create_note({  })
        --     end, { desc = "Obsidian create new notes" })
        -- end,
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
