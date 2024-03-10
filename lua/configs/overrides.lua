local M = {}

M.treesitter = {
  ensure_installed = {
    -- vim
    "vim",
    "vimdoc",

    --lua
    "lua",

    -- markdown
    "markdown",
    "markdown_inline",

    -- bash
    "bash",

    -- c
    "c",

    -- html
    "html",
    -- powershell (not supported)

    -- python
    "pyright",
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
-- lSP server name and mason package name mapping
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
M.mason = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",
    -- powershell
    "powershell-editor-services",
    -- markdown
    "marksman",
    "markdownlint",
    -- python
    "pyright",          -- lsp server
    -- TODO: "debugpy"  -- debugger
    -- "black",         -- formatter
    "ruff",             -- linter, formatter
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

-- enable integrations
M.telescope = {
  extensions_list = { "harpoon", "hbac" },
}

-- enable inline git blame
M.gitsigns = {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
}

return M
