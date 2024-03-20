--[[
    To make a plugin not be loaded 

    { "NvChad/nvim-colorizer.lua",
     enabled = false
    },

    All NvChad plugins are lazy-loaded by default For a plugin to be loaded, 
    you will need to set either `ft`, `cmd`, `keys`, `event`, or set 
    `lazy = false`. If you want a plugin to load on startup, add `lazy = false` 
    to a plugin spec, for example

    {
     "mg979/vim-visual-multi",
     lazy = false,
    }

    Refer to source code of nvchad to see api that shouldn't be overwritten

--]]

return {

    --[[
        ---- Nvchad UI Plugins ----

        Nvchad/base46                        color theme
        Nvchad/ui                            nvchad UI
        Nvchad/nvim-colorizer.lua            color code colorizer
        nvim-tree/nvim-web-devicons          icons
        lukas-reineke/indent-blankline.nvim  indentation line
        nvim-tree/nvim-tree.lua              file tree
        folke/which-key.nvim                 keybind pop up
    --]]

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
        "nvim-tree/nvim-tree.lua",
        opts = function()
            local defaults = require("nvchad.configs.nvimtree")
            local configs = {
                filters = {
                    dotfiles = false,
                    exclude = {},
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                renderer = {
                    highlight_git = true,
                    indent_markers = {
                        enable = true,
                    },
                },
            }
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },

    --[[
        ---- Nvchad Editing Plugins ----

        nvim-lua/plenary.nvim            coroutine library
        stevearc/conform.nvim            formatter
        nvim-treesitter/nvim-treesitter  syntax tree parser
        lewis6991/gitsigns.nvim          git glyph
        williamboman/mason.nvim          language server installer
        neovim/nvim-lspconfig            language server configuration
        hrsh7th/nvim-cmp                 completion engine
        windwp/nvim-autopairs            autopair
        saadparwaiz1/cmp_luasnip         snippet engine
        hrsh7th/cmp-nvim-lua             completion
        hrsh7th/cmp-nvim-lsp             completion
        hrsh7th/cmp-buffer               completion
        hrsh7th/cmp-path                 path completion
        numToStr/Comment.nvim            commenting
        nvim-telescope/telescope.nvim    fuzzy search
    --]]

    {
        "stevearc/conform.nvim",
        opts = require("configs.conform"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            -- NOTE: fix uv_dlopen treesitter error on windows
            -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#llvm-clang
            --
            -- Troubleshooting:
            --  1. Install compilers as mentioned by treesitter page
            --  2. Restart terminal if needed
            --  3. Delete any mason and treesitter related folders in nvim `*-data` folder
            --  4. TSInstall if needed

            if require("custom.os").isWindows() then
                require("nvim-treesitter.install").compilers = { "clang" }
            end

            local defaults = require("nvchad.configs.treesitter")
            local configs = require("configs.treesitter")
            return vim.tbl_deep_extend("force", defaults, configs)
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
            }
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function()
            local defaults = require("nvchad.configs.mason")
            local configs = require("configs.mason")
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
    {
        -- override completion keybinds
        "hrsh7th/nvim-cmp",
        opts = function()
            local defaults = require("nvchad.configs.cmp")
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- NOTE: Overriding insertion behavior (insert when accepted)
            defaults.completion = {
                completeopt = "menu,menuone,noinsert",
            }

            -- NOTE: Overriding code completion keybinds

            -- Accept snippet (tab or C-y)
            -- local accept = {
            --   behavior = cmp.ConfirmBehavior.Insert,
            --   select = true,
            -- }
            defaults.mapping["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
            defaults.mapping["<Tab>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
            defaults.mapping["<S-Tab>"] = nil

            -- Jump to different placeholder location of the snippet
            defaults.mapping["<C-l>"] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" })

            defaults.mapping["<C-h>"] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" })

            return defaults
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

    ---- MY PLUGINS ----

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
        -- Auto save :ASToggle
        "Pocco81/auto-save.nvim",
        event = "BufReadPost",
        opts = {
            enabled = true,
            execution_message = {
                message = function()
                    local osLib = require("custom.os")
                    local msgLib = require("custom.print")
                    return msgLib.msgStr("AutoSave " .. osLib.cwdPath())
                end,
                cleaning_interval = 3000,
            },
        },
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
        -- git
        "tpope/vim-fugitive",
        lazy = false,
    },
    {
        -- peek line using :<number> without jumping to it
        "nacro90/numb.nvim",
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
        opts = {},
    },
    {
        "dstein64/nvim-scrollview",
        event = "BufReadPost",
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

    ---- Fun Plugins ----

    {
        -- :VimBeGood
        "ThePrimeagen/vim-be-good",
        event = "VeryLazy",
    },
    {
        -- :CellularAutomaton make_it_rain
        -- :CellularAutomaton game_of_life
        "eandrju/cellular-automaton.nvim",
        event = "VeryLazy",
    },
}

--[[

  Plugins to look into

  Editing
  https://github.com/karb94/neoscroll.nvim
  https://neovimcraft.com/plugin/folke/zen-mode.nvim

  FILE
  nvim-lsp-file-opreations (for refactoring filenames and imports)

  GIT
  diffview (commit)
  neogit / lazygit (general)
  octo (PR)
  git-conflict (merge)
  nvim-tinygit (git all in one)

  native git mergetool
  diffconflict
  conflict-marker

  COLOR
  https://neovimcraft.com/plugin/RRethy/vim-illuminate

  FORMATTING
  https://neovimcraft.com/plugin/stevearc/conform.nvim

  MISC
  mini.nvim
  dressing.nvim (make select options to use telescope)
  beauwilliams/focus.nvim

  TODO List
  disable nvimtree from opening files within .git directory

--]]
