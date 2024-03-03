---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  nvdash = {
    load_on_startup = true,
    header = require("custom.lib.ascii_arts").randomArt(),
    buttons = {
      { "  Search File", "Spc s f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc s o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc s w", "Telescope live_grep" },
      { "  Bookmarks", "Spc s a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Search keymaps", "Spc s k", "Telescope keymaps" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
  },

  theme = "kanagawa",
  theme_toggle = { "kanagawa", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  telescope = { style = "bordered" }, -- borderless / bordered
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
