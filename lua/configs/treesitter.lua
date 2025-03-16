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
        "toml",
        -- java
        "java",
        -- kotlin
        "kotlin",
        -- rust
        "rust",
        -- perl
        -- "perl",
        -- powershell (not supported)
        "gdscript",
        "gdshader",
        "godot_resource",
    },
    auto_install = true,
}
