-- NOTE: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
return {
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
        -- python
        "python",
        -- java
        "java",
        -- kotlin
        "kotlin",
        -- rust
        "rust",
        -- powershell (not supported)
    },
    auto_install = true,
    indent = {
        enable = true,
        disable = {
            "c",
            "cpp",
            "python",
        },
    },
}
