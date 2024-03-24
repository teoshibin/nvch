local M = {}

M.ui = {

    theme_toggle = { "tokyodark", "one_light" },
    theme = "tokyodark",
    transparency = false,
    telescope = { style = "bordered" }, -- borderless / bordered

    statusline = {
        theme = "minimal", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "round",
    },

    nvdash = {
        load_on_startup = true,
        header = require("custom.art").randomArt(),
        buttons = {
            { "󰈭  Search Word", "Spc s w", "Telescope live_grep" },
            { "  Search File", "Spc s f", "Telescope find_files" },
            { "  Search Keymaps", "Spc s k", "Telescope keymaps" },
            { "  Harpoon", "Spc h l", 'require("harpoon.ui").toggle_quick_menu()' },
            { "  Bookmarks", "Spc s a", "Telescope marks" },
            { "  Cheetsheet", "Spc c h", "NvCheatsheet" },
            { "  Themes", "Spc t h", "Telescope themes" },
        },
    },
}

return M
