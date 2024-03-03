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
    -- TODO: map functions
    -- 
    -- map('n', '<leader>hp', gs.preview_hunk, { desc = '[h]unk [p]review' })
    -- map('n', '<leader>hs', gs.stage_hunk, { desc = '[h]unk [s]tage' })
    -- map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[h]unk [u]nstage' })
    -- map('n', '<leader>hS', gs.stage_buffer, { desc = 'buffer [h]unks [S]tage' })
    -- map('n', '<leader>hr', gs.reset_hunk, { desc = '[h]unk [r]eset' })
    -- map('n', '<leader>hR', gs.reset_buffer, { desc = 'buffer [h]unk [R]eset' })
    -- map('n', '<leader>hd', gs.diffthis, { desc = 'buffer [h]unk [d]iff' })
    --
    -- -- Toggle commit message at the end of cursor line (enabled)
    -- -- map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = ''})
    --
    -- -- Toggle show deleted hunks
    -- -- map('n', '<leader>td', gs.toggle_deleted, { desc = ''})
    --
    -- map('v', '<leader>hs', function()
    --   gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    -- end, { desc = '[h]unk [s]tage selected lines' })
    --
    -- map('v', '<leader>hr', function()
    --   gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    -- end, { desc = '[h]unk [r]eset selected lines' })
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
}

return plugins
