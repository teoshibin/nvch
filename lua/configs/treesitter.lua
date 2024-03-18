-- NOTE: supported language
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
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
            "cpp",
            "python",
        },
    },
}
