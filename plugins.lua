local overrides = require "custom.configs.overrides"

--[[
    mini.nvim
    auto-save
    harphoon.nvim
    numb.nvim
    ecthelionvi/NeoComposer.nvim
    hbac.nvim
    diffview (commit)
    neogit / lazygit (general)
    octo (PR)
    git-conflict (merge)
    nvim-tinygit (git all in one)
    netrw-gx replacement
    dressing.nvim (make select options to use telescope)
    nvim-lsp-file-opreations (for refactoring filenames and imports)
--]]

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    -- { 'j-hui/fidget.nvim', opts = {} },
    -- },
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
      -- require'treesitter-context'.setup() -- TODO: is this working? (https://github.com/nvim-treesitter/nvim-treesitter-context)
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

  ---- MY PLUGINS ----

  -- Highlight todo, notes etc. comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    lazy = false,
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
    lazy = false,
  },
  {
    -- Auto update indentation size
    "NMAC427/guess-indent.nvim",
    opts = {},
    lazy = false,
  },
  {
    -- Sticky line on top of the editor
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
    lazy = false,
  },
}

return plugins
