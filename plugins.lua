local overrides = require "custom.configs.overrides"

--[[
    mini.nvim
    auto-save
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
    -- NOTE: override opts
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
    }
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
      "nvim-lua/plenary.nvim"
    },
    opts = {},
    event = "VeryLazy",
    -- TODO: usage
    -- :lua require("harpoon.mark").add_file()
    -- :lua require("harpoon.ui").toggle_quick_menu()
    -- :lua require("harpoon.ui").nav_file(3) -- navigates without opening menu
    -- :lua require("harpoon.ui").nav_next() -- navigates to next mark
    -- :lua require("harpoon.ui").nav_prev() -- navigates to previous mark
    -- you can go up and down the list, enter, delete or reorder. q and <ESC> exit and save the menu
    -- from the quickmenu, open a file in: a vertical split with control+v, a horizontal split with control+x, a new tab with control+t
    -- lua require("harpoon.term").gotoTerminal(1)             -- navigates to term 1
    -- lua require("harpoon.term").sendCommand(1, "ls -La")    -- sends ls -La to tmux window 1
    -- lua require('harpoon.cmd-ui').toggle_quick_menu()       -- shows the commands menu
    -- lua require("harpoon.term").sendCommand(1, 1)           -- sends command 1 to term 1
  }
}

return plugins
