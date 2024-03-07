local overrides = require "custom.configs.overrides"

--[[
    FILE
    oil.nvim (sort of defeats the purpose of nvim tree)
    nvim-lsp-file-opreations (for refactoring filenames and imports)
    hbac.nvim

    MACRO
    ecthelionvi/NeoComposer.nvim

    GIT
    diffview (commit)
    neogit / lazygit (general)
    octo (PR)
    git-conflict (merge)
    nvim-tinygit (git all in one)

    IDK
    numb.nvim
    mini.nvim
    dressing.nvim (make select options to use telescope)
    beauwilliams/focus.nvim
--]]

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- We shouldn't place the following in lazy.nvim `config` attribute
    -- as that will override existing configuration of nvchad
    opts = function()
      -- NOTE: (custom) fix uv_dlopen treesitter error on windows
      -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#llvm-clang
      -- Trobleshoot:
      --  1. Install compilers as mentioned by treesitter page
      --  2. Restart terminal if needed
      --  3. Delete any mason and treesitter related folders in nvim `*-data` folder
      --  4. TSInstall if needed
      if require("custom.lib.os").isWindows() then
        require("nvim-treesitter.install").compilers = { "clang" }
      end
      return overrides.treesitter
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    -- TODO: deal with conform at some point
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

  {
    -- NOTE: override opts
    "hrsh7th/nvim-cmp",
    opts = function()
      local config = require "plugins.configs.cmp"
      local cmp = require "cmp"
      local luasnip = require "luasnip"

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
      config.mapping["<C-y>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }
      config.mapping["<Tab>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }
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
    opts = overrides.telescope,
  },
  {
    -- NOTE: override opts
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    },
  },

  ---- MY PLUGINS ----

  -- Highlight todo, notes etc. comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    event = "BufReadPost",
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
    event = "BufReadPost",
    opts = {},
  },
  -- {
  --   -- file manager
  --   "stevearc/oil.nvim",
  --   opts = {},
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   lazy = false,
  -- },
  {
    --  auto save
    -- :ASToggle
    "Pocco81/auto-save.nvim",
    event = "BufReadPost",
    opts = {
      execution_message = {
        message = function()
          local filename = vim.fn.expand('%')
          return (vim.fn.strftime "[%H:%M:%S] saved " .. filename)
        end,
        cleaning_interval = 3000,
      },
    },
  },
  {
    -- gx for opening url as netrw got disabled by nvchad
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local os = require "custom.lib.os"
      local browser
      if os.isMac() then
        browser = "open"
      elseif os.isLinux() then
        browser = "xdg-open"
      elseif os.isWindows() then
        browser = "powershell.exe"
      elseif os.isWSL() then
        browser = "powershell.exe" --"wslview"
      else
        print "Can't identify os platform for opening url."
      end
      require("gx").setup {
        open_browser_app = browser,
        open_browser_args = os.isMac() and { "--background" } or {},
        handler_options = {
          search_engine = "google",
        },
      }
    end,
  },
  {
    -- git
    "tpope/vim-fugitive",
    opts = {},
    lazy = false,
  }
}

return plugins
