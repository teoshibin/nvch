require("nvchad.mappings")

local nomap = vim.keymap.del
local map = vim.keymap.set

---- Disable mappings ----

--- Telescope
-- pick hiden term
nomap("n", "<leader>pt")
-- marks
-- nomap("n", "<leader>ma")
-- find
nomap("n", "<leader>ff")
nomap("n", "<leader>fa")
nomap("n", "<leader>fw")
nomap("n", "<leader>fb")
nomap("n", "<leader>fh")
nomap("n", "<leader>fo")
nomap("n", "<leader>fz")
-- git
nomap("n", "<leader>cm")
nomap("n", "<leader>gt")
--- GitSigns
-- nomap("n", "<leader>rh")
-- nomap("n", "<leader>ph")
-- nomap("n", "<leader>gb")

-- New Terminals
nomap("n", "<leader>h")
nomap("n", "<leader>v")

map("n", "<leader>;", function()
    require("nvchad.term").new({ pos = "sp", size = 0.3 })
end, { desc = "Terminal New horizontal term" })

map("n", "<leader>:", function()
    require("nvchad.term").new({ pos = "vsp", size = 0.3 })
end, { desc = "Terminal New vertical window" })

-- TODO: see https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/lspconfig.lua
-- the problem being that the key is set on attach
-- Remap conflicted keymap
-- nomap("n", "<leader>sh")
-- map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Lsp Show signature help")

---- Bind mappings ----

map("n", "<leader>fm", function()
    require("conform").format()
end, { desc = "File Format with conform" })

-- Specials
map("n", "<leader>.", "@@", { desc = "Quick marco" })
map("n", "<leader>n", ":nohl<CR>", { desc = "Hide highlights" })

-- Marks
map("n", "<leader>m", ":marks<Cr>", { desc = "Show marks" })
map("n", "<leader>dm", ":delmarks a-zA-Z0-9<Cr>", { desc = "Delete all marks" })

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- New Line
map("n", "<leader>o", 'o<Esc>0"_D', { desc = "Add newline below" })
map("n", "<leader>O", 'O<Esc>0"_D', { desc = "Add newline above" })

-- Reselect Pasted
map("n", "gp", "`[v`]", { desc = "[g]o reselect [p]asted in visual mode" })
map("n", "gP", "`[V`]", { desc = "[g]o reselect [P]asted in Visual line mode" })

-- Centered Jump
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Centered Stack Jump
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

-- Centered Find
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Centered Function Jump
map("n", "[m", "[mzz")
map("n", "]m", "]mzz")

-- Paste on top
map("v", "p", "pgvy")

-- Move Lines
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })

-- Reslect Indented Lines
map("v", ">", ">gv", { desc = "Visual line indent right" })
map("v", "<", "<gv", { desc = "Visual line indent left" })

-- close other buffers
map("n", "<leader>X", "<cmd> w|%bd|e#|bd# <CR>", { silent = true, desc = "Buffer close other buffers", noremap = true })

---- Existing Keybinds ----

-- Quick Escape
-- map("i", "jj", "<Esc>", { desc = "Quick Escape" })
-- map("i", "jk", "<Esc>", { desc = "Quick Escape 2" })

-- Select Current Line
-- ["<leader>v"] = { "^vg_", "Visual select current line" },

---- TELESCOPE ----

-- pick a hidden term
map("n", "<leader>st", "<cmd> Telescope terms <CR>", { desc = "Pick hidden term" })
-- marks
map("n", "<leader>sm", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })
-- find
map("n", "<leader>sf", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>sa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>sw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>sb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>sh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>so", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>sz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
map("n", "<leader>sk", "<cmd> Telescope keymaps <CR>", { desc = "Find keymaps" })
-- git
map("n", "<leader>gl", "<cmd> Telescope git_commits <CR>", { desc = "Git commits logs" })
map("n", "<leader>gs", "<cmd> Telescope git_status <CR>", { desc = "Git status" })

-- telescope nvim config
map("n", "<leader>sn", function()
    local builtin = require("telescope.builtin")
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

---- harpoon ----

-- TODO: usage
-- you can go up and down the list, enter, delete or reorder. q and <ESC> exit and save the menu
-- quickmenu: vertical split <C-v>, horizontal split <C-x>, a new tab with <C-t>
--
-- lua require("harpoon.term").gotoTerminal(1)             -- navigates to term 1
-- lua require("harpoon.term").sendCommand(1, "ls -La")    -- sends ls -La to tmux window 1
-- lua require('harpoon.cmd-ui').toggle_quick_menu()       -- shows the commands menu
-- lua require("harpoon.term").sendCommand(1, 1)           -- sends command 1 to term 1
-- ["<leader>sl"] = { "<cmd> Telescope harpoon marks <CR>", "Telescope harpoon list" },

map("n", "<leader>ha", function()
    require("harpoon.mark").add_file()
    local file = require("custom.path").current_buffer()
    print("Harpoon " .. file)
end, { desc = "Harpoon add" })

map("n", "<leader>hl", function()
    require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpooned list" })

map("n", "<M-p>", function()
    require("harpoon.ui").nav_prev()
end, { desc = "Harpoon previous" })

map("n", "<M-n>", function()
    require("harpoon.ui").nav_next()
end, { desc = "Harpoon next" })

map("n", "<leader>hs", function()
    require("harpoon.ui").nav_file(1)
end, { desc = "Harpoon 1" })

map("n", "<leader>hd", function()
    require("harpoon.ui").nav_file(2)
end, { desc = "Harpoon 2" })

map("n", "<leader>hf", function()
    require("harpoon.ui").nav_file(3)
end, { desc = "Harpoon 3" })

map("n", "<leader>hg", function()
    require("harpoon.ui").nav_file(4)
end, { desc = "Harpoon 4" })

---- GitSigns ----

-- Navigation through hunks (add zz after execution)
map("n", "]c", function()
    if vim.wo.diff then
        return "]c"
    end
    vim.schedule(function()
        require("gitsigns").next_hunk()
        vim.api.nvim_feedkeys("zz", "n", true) -- Added this
    end)
    return "<Ignore>"
end, { desc = "Jump to next hunk", expr = true })

map("n", "[c", function()
    if vim.wo.diff then
        return "[c"
    end
    vim.schedule(function()
        require("gitsigns").prev_hunk()
        vim.api.nvim_feedkeys("zz", "n", true) -- Added this
    end)
    return "<Ignore>"
end, { desc = "Jump to prev hunk", expr = true })

-- Custom gitsigns keymaps
map("n", "<leader>gh", function()
    require("gitsigns").preview_hunk()
end, { desc = "Git preview hunk" })

map("n", "<leader>gah", function()
    require("gitsigns").stage_hunk()
end, { desc = "Git add (stage) hunk" })

map("n", "<leader>guh", function()
    require("gitsigns").undo_stage_hunk()
end, { desc = "Git unstage hunk" })

map("n", "<leader>grh", function()
    require("gitsigns").reset_hunk()
end, { desc = "Git reset hunk" })

map("n", "<leader>gab", function()
    require("gitsigns").stage_buffer()
end, { desc = "Git add (stage) buffer" })

map("n", "<leader>grb", function()
    require("gitsigns").reset_buffer()
end, { desc = "Git reset buffer" })

map("n", "<leader>gdh", function()
    require("gitsigns").diffthis()
end, { desc = "Git diff hunk" })

map("n", "<leader>gah", function()
    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Git add (stage) selected hunk" })

map("n", "<leader>grh", function()
    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Git reset selected hunk" })

---- Auto-session ----

-- map("n", "<leader>sl", function()
--     require("auto-session.session-lens").search_session()
-- end, { desc = "Session list" })

---- Nvchad color ----

map("n", "<leader>tt", function()
    require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })

---- conform ----

map("n", "<leader>fm", function()
    require("conform").format()
end, { desc = "formatting" })

return {}
