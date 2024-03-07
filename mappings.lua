---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- [[ Telescope ]]
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

    -- [[ GitSigns ]]
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",

    -- [[ Terminal ]]
    -- TODO: fix new terminal
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    -- ["<leader>h"] = {
    --   function()
    --     require("nvterm.terminal").new "horizontal"
    --   end,
    --   "New horizontal term",
    -- },
    --
    -- ["<leader>v"] = {
    --   function()
    --     require("nvterm.terminal").new "vertical"
    --   end,
    --   "New vertical term",
    -- },
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

M.gitsigns = {
  n = {
    -- Navigation through hunks (add zz after execution)
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
          vim.api.nvim_feedkeys("zz", "n", true) -- Added this
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
          vim.api.nvim_feedkeys("zz", "n", true) -- Added this
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },
    -- Custom gitsigns keymaps
    ["<leader>gh"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Git preview hunk",
    },
    ["<leader>gah"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Git add (stage) hunk",
    },
    ["<leader>guh"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Git unstage hunk",
    },
    ["<leader>grh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Git reset hunk",
    },
    ["<leader>gab"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Git add (stage) buffer",
    },
    ["<leader>grb"] = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Git reset buffer",
    },
    ["<leader>gdh"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "Git diff hunk",
    },
  },
  v = {
    ["<leader>gah"] = {
      function()
        require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end,
      "Git add (stage) selected hunk",
    },
    ["<leader>grh"] = {
      function()
        require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end,
      "Git reset selected hunk",
    },
  },
}

M.harpoon = {
  -- TODO: usage
  -- you can go up and down the list, enter, delete or reorder. q and <ESC> exit and save the menu
  -- from the quickmenu, open a file in: a vertical split with control+v, a horizontal split with control+x, a new tab with control+t
  --
  -- lua require("harpoon.term").gotoTerminal(1)             -- navigates to term 1
  -- lua require("harpoon.term").sendCommand(1, "ls -La")    -- sends ls -La to tmux window 1
  -- lua require('harpoon.cmd-ui').toggle_quick_menu()       -- shows the commands menu
  -- lua require("harpoon.term").sendCommand(1, 1)           -- sends command 1 to term 1
  -- plugin = true,
  n = {
    ["<leader>ha"] = {
      function()
        require("harpoon.mark").add_file()
        local osLib = require "custom.lib.os"
        local msgLib = require "custom.lib.print"
        msgLib.msg("Harpoon " .. osLib.cwdPath())
      end,
      "Harpoon add",
    },
    ["<leader>sl"] = { "<cmd> Telescope harpoon marks <CR>", "Telescope harpoon list" },
    ["<leader>hl"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "Harpooned list",
    },
    ["<leader>hs"] = {
      function()
        require("harpoon.ui").nav_file(1)
      end,
      "Harpoon 1",
    },
    ["<leader>hd"] = {
      function()
        require("harpoon.ui").nav_file(2)
      end,
      "Harpoon 2",
    },
    ["<leader>hf"] = {
      function()
        require("harpoon.ui").nav_file(3)
      end,
      "Harpoon 3",
    },
    ["<leader>hg"] = {
      function()
        require("harpoon.ui").nav_file(4)
      end,
      "Harpoon 4",
    },
    ["<M-p>"] = {
      function()
        require("harpoon.ui").nav_prev()
      end,
      "Harpoon previous",
    },
    ["<M-n>"] = {
      function()
        require("harpoon.ui").nav_next()
      end,
      "Harpoon next",
    },
  },
}

return M
