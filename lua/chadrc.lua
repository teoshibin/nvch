local M = {}

M.ui = {

    theme_toggle = { "kanagawa", "one_light" },
    theme = "kanagawa",
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

    term = {
        sizes = { sp = 0.3, vsp = 0.4 },
        float = {
            row = 0.07,
            col = 0.095,
            width = 0.8,
            height = 0.75,
        },
    },
}

M.base46 = {
    integrations = {
        "dap",
    },
}

return M
