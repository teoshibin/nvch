local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "markdown",
    "markdown_inline",
    "bash", 
    "c", 
    "html",
  },
  auto_install = true,
  -- highlight = { enable = true },
  indent = {
    enable = true,
    disable = { "c", "cpp" },
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    dotfiles = false,
    exclude = {},
  },
  git = {
    enable = true,
    ignore = false,
  },
  -- disable_netrw = false,
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
  },
}

return M
