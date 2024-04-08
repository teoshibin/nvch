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
