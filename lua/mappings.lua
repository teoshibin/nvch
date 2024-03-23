local M = {}

local nomap = vim.keymap.del
local map = vim.keymap.set

function M.auto_session()
    map("n", "<leader>sl", function()
        require("auto-session.session-lens").search_session()
    end, { desc = "Session list" })
end

function M.conform()
    map({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format Reformat code" })
end

function M.general()
    require("nvchad.mappings")

    nomap({ "n", "t" }, "<A-v>")
    nomap({ "n", "t" }, "<A-h>")
    nomap({ "n", "t" }, "<A-i>")

    map({ "n", "t" }, " <A-v>", function()
        require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm", size = 0.4 })
    end, { desc = "Terminal Toggleable vertical term" })

    map({ "n", "t" }, "<A-h>", function()
        require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm", size = 0.4 })
    end, { desc = "Terminal New horizontal term" })

    map({ "n", "t" }, "<A-i>", function()
        require("nvchad.term").toggle({ pos = "float", id = "floatTerm", size = 0.7 })
    end, { desc = "Terminal Toggle Floating term" })

    -- nvchad toggle transparency
    map("n", "<leader>tt", function()
        require("base46").toggle_transparency()
    end, { desc = "Toggle Transparency" })

    -- new horizontal terminals
    nomap("n", "<leader>h")
    map("n", "<leader>H", function()
        require("nvchad.term").new({ pos = "sp", size = 0.3 })
    end, { desc = "Terminal New horizontal terminal" })

    -- new vertical terminal
    nomap("n", "<leader>v")
    map("n", "<leader>V", function()
        require("nvchad.term").new({ pos = "vsp", size = 0.3 })
    end, { desc = "Terminal New vertical terminal" })

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
    map(
        "n",
        "<leader>X",
        "<cmd> w|%bd|e#|bd# <CR>",
        { silent = true, desc = "Buffer close other buffers", noremap = true }
    )

    ---- Existing Keybinds ----

    -- Quick Escape
    -- map("i", "jj", "<Esc>", { desc = "Quick Escape" })
    -- map("i", "jk", "<Esc>", { desc = "Quick Escape 2" })

    -- Select Current Line
    -- ["<leader>v"] = { "^vg_", "Visual select current line" },
end

function M.gitsigns(buffer)
    local gs = require("gitsigns")

    -- Navigate next hunks (added zz)
    map("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
            vim.api.nvim_feedkeys("zz", "n", true) -- Added this
        end)
        return "<Ignore>"
    end, { buffer = buffer, desc = "Gitsign Next hunk", expr = true })

    -- Navigate previous hunk (added zz)
    map("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
            vim.api.nvim_feedkeys("zz", "n", true) -- Added this
        end)
        return "<Ignore>"
    end, { buffer = buffer, desc = "Gitsign Previous hunk", expr = true })

    -- preview hunk
    map("n", "<leader>hp", function()
        gs.preview_hunk()
    end, { buffer = buffer, desc = "Gitsign Preview hunk" })

    -- stage hunk
    map("n", "<leader>hs", function()
        gs.stage_hunk()
    end, { buffer = buffer, desc = "Gitsign Stage Hunk" })

    -- unstage hunk
    map("n", "<leader>hu", function()
        gs.undo_stage_hunk()
    end, { buffer = buffer, desc = "Gitsign Unstage hunk" })

    -- reset hunk
    map("n", "<leader>hr", function()
        gs.reset_hunk()
    end, { buffer = buffer, desc = "Gitsign Reset hunk" })

    -- diff hunk
    map("n", "<leader>hd", function()
        gs.diffthis()
    end, { buffer = buffer, desc = "Gitsign Diff hunk" })

    -- stage selected hunk
    map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { buffer = buffer, desc = "Gitsign Stage selected hunk" })

    -- unstage selected hunk
    map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { buffer = buffer, desc = "Gitsign Reset selected hunk" })

    -- Use neogit instead
    -- map("n", "<leader>hS", function()
    --     gs.stage_buffer()
    -- end, { desc = "Gitsign Stage current buffer" })

    -- Use neogit instead
    -- map("n", "<leader>hR", function()
    --     gs.reset_buffer()
    -- end, { desc = "Gitsign Reset current buffer" })
end

function M.harpoon()
    --[[
        q or <ESC>:
            exit and save the menu

        quick mneu open: 
            <C-v> vertical split
            <C-x> horizontal split
            <C-t> new tab

        lua require("harpoon.term").gotoTerminal(1)             -- navigates to term 0
        lua require("harpoon.term").sendCommand(1, "ls -La")    -- sends ls -La to tmux window 1
        lua require('harpoon.cmd-ui').toggle_quick_menu()       -- shows the commands menu
        lua require("harpoon.term").sendCommand(1, 1)           -- sends command 1 to term 1
        ["<leader>sl"] = { "<cmd> Telescope harpoon marks <CR>", "Telescope harpoon list" },
    --]]

    map("n", "<leader>ha", function()
        require("harpoon.mark").add_file()
        local file = require("custom.path").current_buffer()
        print("Harpoon " .. file)
    end, { desc = "Harpoon Add current buffer" })

    map("n", "<leader>hl", function()
        require("harpoon.ui").toggle_quick_menu()
    end, { desc = "Harpoon List buffers" })

    map("n", "<M-p>", function()
        require("harpoon.ui").nav_prev()
    end, { desc = "Harpoon Previous buffer" })

    map("n", "<M-n>", function()
        require("harpoon.ui").nav_next()
    end, { desc = "Harpoon Next buffer" })

    map("n", "<leader>h1", function()
        require("harpoon.ui").nav_file(1)
    end, { desc = "Harpoon Navigate 1st buffer" })

    map("n", "<leader>h2", function()
        require("harpoon.ui").nav_file(2)
    end, { desc = "Harpoon Navigate 2nd buffer" })

    map("n", "<leader>h3", function()
        require("harpoon.ui").nav_file(3)
    end, { desc = "Harpoon Navigate 3rd buffer" })

    map("n", "<leader>h4", function()
        require("harpoon.ui").nav_file(4)
    end, { desc = "Harpoon Navigate 4th buffer" })
end

function M.neogit()
    map("n", "<leader>gg", "<cmd> Neogit <CR>", { desc = "Git Neogit window" })
    map({ "n", "t" }, "<A-g>", "<cmd> Neogit kind=floating <CR>", { desc = "Git Neogit floating window" })
end

function M.telescope()
    -- TODO: see https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/lspconfig.lua
    -- the problem being that the key is set on attach
    -- Remap conflicted keymap
    -- nomap("n", "<leader>sh")
    -- map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Lsp Show signature help")

    -- hiden term
    nomap("n", "<leader>pt")
    map("n", "<leader>st", "<cmd> Telescope terms <CR>", { desc = "Telescope Search terminals" })

    -- replace find with search
    nomap("n", "<leader>ff")
    map("n", "<leader>sf", "<cmd> Telescope find_files <CR>", { desc = "Telescope Search files" })

    -- search all
    nomap("n", "<leader>fa")
    map(
        "n",
        "<leader>sa",
        "<cmd> Telescope find_files" .. " follow=true no_ignore=true hidden=true <CR>",
        { desc = "Telescope Search all" }
    )

    -- search word
    nomap("n", "<leader>fw")
    map("n", "<leader>sw", "<cmd> Telescope live_grep <CR>", { desc = "Telescope Search word (Live grep)" })

    -- search buffers
    nomap("n", "<leader>fb")
    map("n", "<leader>sb", "<cmd> Telescope buffers <CR>", { desc = "Telescope Search buffers" })

    -- search help
    nomap("n", "<leader>fh")
    map("n", "<leader>sh", "<cmd> Telescope help_tags <CR>", { desc = "Telescope Search Help" })

    -- search old files
    nomap("n", "<leader>fo")
    map("n", "<leader>so", "<cmd> Telescope oldfiles <CR>", { desc = "Telescope Search oldfiles" })

    -- search word in current buffer
    nomap("n", "<leader>fz")
    map(
        "n",
        "<leader>sz",
        "<cmd> Telescope current_buffer_fuzzy_find <CR>",
        { desc = "Telescope Search word in current buffer" }
    )

    -- search keymaps
    map("n", "<leader>sk", "<cmd> Telescope keymaps <CR>", { desc = "Telescope Search keymaps" })

    -- search git commits
    nomap("n", "<leader>cm")
    map("n", "<leader>sc", "<cmd> Telescope git_commits <CR>", { desc = "Telescope Search git commits" })

    -- search git diffs
    nomap("n", "<leader>gt")
    map("n", "<leader>sd", "<cmd> Telescope git_status <CR>", { desc = "Telescope Search git diffs" })

    -- search marks
    map("n", "<leader>sm", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })

    -- search neovim config
    map("n", "<leader>sn", function()
        local builtin = require("telescope.builtin")
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Telescope Search neovim configs" })
end

function M.setup()
    M.general()
    M.telescope()
end

return M
