local M = {}

-- NOTE: supported language
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
M.treesitter = {
    ensure_installed = {

        --lua
        "lua",

        -- vim
        "vim",
        "vimdoc",

        -- markdown
        "markdown",
        "markdown_inline",

        -- bash
        "bash",

        -- html
        "html",

        -- powershell (not supported)

        -- python
        "python",

        -- java
        "java",

        -- kotlin
        "kotlin",
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
        "lua-language-server", -- lsp
        "stylua", -- formatter

        -- powershell
        "powershell-editor-services", -- lsp

        -- markdown
        "marksman", -- lsp
        "markdownlint", -- linter

        -- python
        "pyright", -- lsp server
        -- "debugpy", -- debugger
        -- "black",   -- formatter
        "ruff", -- linter, formatter

        -- kotlin
        "kotlin-language-server", -- lsp
        -- "kotlin-debug-adapter", -- debugger
        "ktlint", -- linter, formatter

        -- java
        "jdtls", -- lsp
        -- "java-debug-adapter",  -- debugger
        "checkstyle", -- linter
        "google-java-format", -- formatter
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
