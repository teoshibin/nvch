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
    -- powershell not supported
  },
  auto_install = true,
  indent = {
    enable = true,
    disable = {
      "c",
      "cpp", --[["python"]]
    },
  },
}

-- NOTE: See :Mason to check for server name
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
M.mason = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",
    -- powershell
    "powershell-editor-services",
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
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
  },
}

M.telescope = {
  extensions_list = { "harpoon" },
}

return M
