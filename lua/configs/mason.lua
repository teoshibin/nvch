-- NOTE: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md 
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
        "basedpyright", -- lsp server
        "debugpy", -- debugger
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
        -- "rust-analyzer", (see ../plugins/rust.lua)
        "codelldbl", -- debugger

        -- -- perl
        -- "perlnavigator",
    },
}
