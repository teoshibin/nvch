-- To make a plugin not be loaded
-- {
--  "NvChad/nvim-colorizer.lua",
--  enabled = false
-- },
--
-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
-- {
--  "mg979/vim-visual-multi",
--  lazy = false,
-- }

local overrides = require("configs.overrides")

return {

  ---- Useless plugins ----
  
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

  ---- Overrides ----

    -- In order to override please the source code of Nvchad, specifically 
    -- the plugin folder. The reason being that otherwise we might be overriding
    -- configurations that we want 

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function()
      local options = require("nvchad.configs.mason")
      return vim.tbl_deep_extend("force", options, overrides.mason)
    end,
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

      if require("lib.os").isWindows() then
        require("nvim-treesitter.install").compilers = { "clang" }
      end

      local options = require("nvchad.configs.treesitter")
      return vim.tbl_deep_extend("force", options, overrides.treesitter)
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local options = require("nvchad.configs.nvimtree")
      return vim.tbl_deep_extend("force", options, overrides.nvimtree)
    end,
  },
  {
    -- override completion keybinds
    "hrsh7th/nvim-cmp",
    opts = function()
      local config = require("nvchad.configs.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- NOTE: Overriding insertion behavior (insert when accepted)
      config.completion = {
        completeopt = "menu,menuone,noinsert",
      }

      -- NOTE: Overriding code completion keybinds

      -- Accept snippet (tab or C-y)
      -- local accept = {
      --   behavior = cmp.ConfirmBehavior.Insert,
      --   select = true,
      -- }
      config.mapping["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
      config.mapping["<Tab>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
      config.mapping["<S-Tab>"] = nil

      -- Jump to different placeholder location of the snippet
      config.mapping["<C-l>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
        end, { "i", "s" })

      config.mapping["<C-h>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
        end, { "i", "s" })

      return config
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local options = require("nvchad.configs.telescope")
      return vim.tbl_deep_extend("force", options, overrides.telescope)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function ()
      local options = require("nvchad.configs.gitsigns")
      return vim.tbl_deep_extend("force", options, overrides.gitsigns)
    end,
  },

  ---- MY PLUGINS ----

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require("configs.conform")
    end,
  },
  {
    -- Surround motion
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },
  {
    -- Indentation virtical guide line
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "BufReadPost",
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
          local osLib = require("lib.os")
          local msgLib = require("lib.print")
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
    -- auto close buffers
    "axkirillov/hbac.nvim",
    opts = {
      -- autoclose = false,
      -- NOTE: require('telescope').extensions.hbac.buffers()
      -- :Telescope hbac buffers
      threshold = 5,
      close_command = function(bufnr)
        local osLib = require("lib.os")
        local msgLib = require("lib.print")
        local filename = osLib.cwdPath(bufnr)
        if filename ~= "" then
          msgLib.msg("AutoClose " .. filename)
        end
        vim.api.nvim_buf_delete(bufnr, {})
      end,
    },
    event = "BufReadPost",
  },
  -- FIX: re-enable this at some point
  -- {
  --  -- resume with previous buffers
  --  "rmagatti/auto-session",
  --  lazy = false,
  --  config = function()
  --   require("auto-session").setup({
  --    log_level = "error",
  --    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  --   })
  --  end,
  -- },
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
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
  }
}

--[[

  Plugins to look into

  FILE
  nvim-lsp-file-opreations (for refactoring filenames and imports)

  GIT
  diffview (commit)
  neogit / lazygit (general)
  octo (PR)
  git-conflict (merge)
  nvim-tinygit (git all in one)

  COLOR
  https://neovimcraft.com/plugin/RRethy/vim-illuminate

  FORMATTING
  https://neovimcraft.com/plugin/stevearc/conform.nvim

  MISC
  mini.nvim
  dressing.nvim (make select options to use telescope)
  beauwilliams/focus.nvim

--]]
