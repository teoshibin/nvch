local M = {}

M.base46 = {
    theme = "catppuccin",
    theme_toggle = { "catppuccin", "aquarium" },
    transparency = false,
    integrations = {
        "dap",
    },
}

M.term = {
    sizes = { sp = 0.3, vsp = 0.4 },
    float = {
        row = 0.07,
        col = 0.095,
        width = 0.8,
        height = 0.75,
    },
}

M.mason = {
    pkgs = {
        -- Lua
        "lua-language-server", -- lsp
        "stylua",              -- formatter

        -- Powershell
        "powershell-editor-services", -- lsp

        -- Markdown
        "marksman",     -- lsp
        "markdownlint", -- linter
        "ltex-ls",      -- grammar checker

        -- Python
        "basedpyright", -- lsp server
        "debugpy",      -- debugger
        "ruff",         -- linter, formatter

        -- Kotlin
        "kotlin-language-server", -- lsp
        -- "kotlin-debug-adapter", -- debugger
        "ktlint",                 -- linter, formatter

        -- Java
        "jdtls",                 -- lsp
        -- "java-debug-adapter", -- debugger
        "checkstyle",            -- linter
        "google-java-format",    -- formatter

        -- Rust
        -- "rust-analyzer", -- lsp (use the one from rustup)
        "codelldbl", -- debugger
    }
}

M.ui = {

    telescope = { style = "bordered" }, -- borderless / bordered

    statusline = {
        theme = "minimal", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "round",
    },

    nvdash = {
        load_on_startup = true,
        header = {
            "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        },
        buttons = {
            { "  Search File", "Spc s f", "Telescope find_files" },
            { "  Search Keymaps", "Spc s k", "Telescope keymaps" },
            { "  Harpoon", "Spc h l", 'require("harpoon.ui").toggle_quick_menu()' },
            { "  Themes", "Spc t h", "Telescope themes" },
            { "  Cheetsheet", "Spc c h", "NvCheatsheet" },
        },
    },
}

return M

