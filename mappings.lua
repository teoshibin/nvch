---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- [[ Telescope Remap ]]
    -- pick hiden term
    ["<leader>pt"] = "",
    -- marks
    ["<leader>ma"] = "",
    -- find
    ["<leader>ff"] = "",
    ["<leader>fa"] = "",
    ["<leader>fw"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",
    ["<leader>fz"] = "",
    -- git
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
  },
}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    -- [[ My Custom ]] --
    -- Specials
    ["<leader>."] = { "@@", "Quick marco" },
    ["<leader>n"] = { ":nohl<CR>", "Hide highlights" },
    -- Marks
    ["<leader>m"] = { ":marks<Cr>", "Show marks" },
    ["<leader>dm"] = { ":delmarks a-zA-Z0-9<Cr>", "Delete all marks" },
    -- Move Lines
    ["<A-j>"] = { ":m .+1<CR>==", "Move line down" },
    ["<A-k>"] = { ":m .-2<CR>==", "Move line up" },
    -- New Line
    ["<leader>o"] = { 'o<Esc>0"_D', "Add newline below" },
    ["<leader>O"] = { 'O<Esc>0"_D', "Add newline above" },
    -- Reselect Pasted
    ["gp"] = { "`[v`]", "[g]o reselect [p]asted in visual mode" },
    ["gP"] = { "`[V`]", "[g]o reselect [P]asted in Visual line mode" },
    -- Centered Jump
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    -- Centered Find
    ["n"] = { "nzz" },
    ["N"] = { "Nzz" },
    -- Centered Function Jump
    ["[m"] = { "[mzz" },
    ["]m"] = { "]mzz" },

    -- [[ Existing Keybinds ]]
    --
    -- Quick Escape
    -- map('i', 'jj', '<Esc>', { desc = 'Quick Escape' })
    -- map('i', 'jk', '<Esc>', { desc = 'Quick Escape 2' })
    --
    -- Paste on top
    -- map("v", "p", "pgvy"),
  },
  v = {
    -- Move Lines
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move selected lines up" },
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move selected lines down" },
    -- Reslect Indented Lines
    [">"] = { ">gv", "Visual line indent right" },
    ["<"] = { "<gv", "Visual line indent left" },
    -- Select Current Line
    -- ["<leader>v"] = { "^vg_", "Visual select current line" },
  },
}

M.telescope = {
  n = {

    -- pick a hidden term
    ["<leader>st"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- marks
    ["<leader>sm"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },

    -- find
    ["<leader>sf"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>sa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>sw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>sb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>sh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>so"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>sz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    ["<leader>sk"] = { "<cmd> Telescope keymaps <CR>", "Find keymaps" },

    -- git
    ["<leader>gl"] = { "<cmd> Telescope git_commits <CR>", "Git commits logs" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- neovim config
    ["<leader>sn"] = {
      function()
        local builtin = require "telescope.builtin"
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end,
      "[S]earch [N]eovim files",
    },
  },
}

return M
