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
            -- NOTE: additional preview sroll
            -- https://github.com/nvim-telescope/telescope.nvim/issues/2602
            local state = require("telescope.state")
            local action_state = require("telescope.actions.state")
            local slow_scroll = function(prompt_bufnr, direction)
                local previewer = action_state.get_current_picker(prompt_bufnr).previewer
                local status = state.get_status(prompt_bufnr)
                -- Check if we actually have a previewer and a preview window
                if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                    return
                end
                previewer:scroll_fn(1 * direction)
            end
            local full_page_scroll = function(prompt_bufnr, direction)
                local previewer = action_state.get_current_picker(prompt_bufnr).previewer
                local status = state.get_status(prompt_bufnr)
                -- Check if we actually have a previewer and a preview window
                if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                    return
                end
                local speed = vim.api.nvim_win_get_height(status.preview_win)
                previewer:scroll_fn(speed * direction)
            end

            local defaults = require("nvchad.configs.telescope")
            local configs = {
                extensions_list = { "harpoon", "session-lens", "heading", "aerial" },
                extensions = {
                    heading = {
                        treesitter = true,
                    },
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<C-e>"] = function(bufnr)
                                slow_scroll(bufnr, 1)
                            end,
                            ["<C-y>"] = function(bufnr)
                                slow_scroll(bufnr, -1)
                            end,
                            ["<C-b>"] = function(bufnr)
                                full_page_scroll(bufnr, 1)
                            end,
                            ["<C-f>"] = function(bufnr)
                                full_page_scroll(bufnr, -1)
                            end,
                        },
                    },
                },
            }
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        "crispgm/telescope-heading.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
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
        opts = {
            input = {
                mappings = {
                    i = {
                        ["<C-p>"] = "HistoryPrev",
                        ["<C-n>"] = "HistoryNext",
                    },
                },
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = "<leader>z",
        config = function(opts)
            require("zen-mode").setup(opts)
            require("mappings").zenMode()
        end,
    },
    {
        -- inspect panel for quickfix list
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        -- file manager
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 5,
                win_options = {
                    winblend = 5,
                },
            },
            keymaps = {
                ["<leader>-"] = "actions.close",
            },
        },
        cmd = "Oil",
        keys = {
            { "<leader>-", "<CMD>Oil<CR>", mode = "n", desc = "Toggle oil file manager" },
        },
    },
}
