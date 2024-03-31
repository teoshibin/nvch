-- NOTE: See :Mason to check for server name
-- lSP server name and mason package name mapping
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
return {
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

        -- rust
        "rust-analyzer",
    },
}
