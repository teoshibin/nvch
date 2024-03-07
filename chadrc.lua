---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  nvdash = {
    load_on_startup = true,
    header = require("custom.lib.ascii_arts").randomArt(),
    buttons = {
      { "󰈭  Search Word", "Spc s w", "Telescope live_grep" },
      { "  Search File", "Spc s f", "Telescope find_files" },
      { "  Search Keymaps", "Spc s k", "Telescope keymaps" },
      { "  Harpoon", "Spc h l", "require(\"harpoon.ui\").toggle_quick_menu()" },
      { "  Bookmarks", "Spc s a", "Telescope marks" },
      { "  Cheetsheet", "Spc c h", "NvCheatsheet" },
      { "  Themes", "Spc t h", "Telescope themes" },
    },
  },

  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
  },

  theme = "tokyodark",
  theme_toggle = { "tokyodark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  telescope = { style = "bordered" }, -- borderless / bordered
}

M.plugins = "custom.plugins"

M.lazy_nvim = {
  lockfile = vim.fn.stdpath("config") .. "lua/custom/lazy-lock.json",
}

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
