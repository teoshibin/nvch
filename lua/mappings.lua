local M = {}

M.nomap = vim.keymap.del
function M.map(modes, lhs, rhs, opts)
    opts = opts or {}
    local default_opts = { noremap = false }
    opts = vim.tbl_deep_extend("force", default_opts, opts)
    vim.keymap.set(modes, lhs, rhs, opts)
end

local map = M.map
local nomap = M.nomap

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

    -- unmap for trouble
    nomap("n", "<leader>e")

    -- unmap for dap
    nomap("n", "<leader>b")

    -- unmap for obisidian
    nomap("n", "<leader>n")

    -- tabs

    map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "General new tab" })
    map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "General close tab" })
    map("n", "[t", "<cmd>tabp<CR>", { desc = "General previous tab" })
    map("n", "]t", "<cmd>tabn<CR>", { desc = "General next tab" })
    map("n", "<leader>ts", "<cmd>tab split<CR>", { desc = "general current buffer in new tab" })

    ---- Terminals ----

    -- resize terminals
    nomap({ "n", "t" }, "<A-h>")
    nomap({ "n", "t" }, "<A-v>")

    map(
        { "n", "t" },
        "<A-s>",
        require("custom.term").toggle_horizontal_term,
        { desc = "Terminal Toggle horizontal term" }
    )
    map({ "n", "t" }, "<A-v>", require("custom.term").toggle_vertical_term, { desc = "Terminal Toggle vertical term" })
    map({ "n", "t" }, "<A-i>", require("custom.term").toggle_floating_term, { desc = "Terminal toggle floating term" })

    -- new horizontal terminals
    nomap("n", "<leader>h")
    map("n", "<leader><A-s>", function()
        require("nvchad.term").new({ pos = "sp", size = 0.4 })
    end, { desc = "Terminal New horizontal term" })

    -- new vertical terminal
    nomap("n", "<leader>v")
    map("n", "<leader><A-v>", function()
        require("nvchad.term").new({ pos = "vsp", size = 0.5 })
    end, { desc = "Terminal New vertical term" })

    map("t", "<C-l>", "<C-\\><C-n><C-w><C-l>")
    map("t", "<C-h>", "<C-\\><C-n><C-w><C-h>")
    map("t", "<C-k>", "<C-\\><C-n><C-w><C-k>")
    map("t", "<C-j>", "<C-\\><C-n><C-w><C-j>")

    ---- UI ----

    -- nvchad toggle transparency
    map("n", "<leader>tt", function()
        require("base46").toggle_transparency()
    end, { desc = "Toggle Transparency" })

    map("n", "<A-l>", function()
        require("nvchad.tabufline").next()
    end, { desc = "Buffer Goto next" })

    map("n", "<A-h>", function()
        require("nvchad.tabufline").prev()
    end, { desc = "Buffer Goto prev" })

    ---- Quickfix List ----

    map("n", "[q", "<cmd>cprevious<CR>", { desc = "Quickfix Previous quickfix" })
    map("n", "]q", "<cmd>cnext<CR>", { desc = "Quickfix Next quickfix" })

    ---- Custom ----

    -- Fix for mac iterm backspacing a word
    if require("custom.os").isMac() and vim.fn.getenv("TERM_PROGRAM") == "iTerm.app" then
        map("i", "<Esc><BS>", "<C-w>")
    end

    -- Fix and prevent identation of empty lines for being deleted
    map("n", "i", function()
        local current_line = vim.fn.line(".")
        local last_line = vim.fn.line("$")
        local buftype = vim.bo.buftype
        if #vim.api.nvim_get_current_line() == 0 and last_line ~= current_line and buftype ~= "terminal" then
            return '"_ddO'
        end
        return "i"
    end, { noremap = true, expr = true, desc = "Smart insert indentation" })

    -- Specials

    map("i", "jj", "<Esc>", { desc = "Quick Escape" })
    map("n", "<leader>.", "@@", { desc = "General Repeat last marco" })

    map("n", "<leader>tln", "<cmd>set nu!<CR>", { desc = "Toggle Line number" })

    nomap("n", "<leader>rn")
    map("n", "<leader>trn", "<cmd>set rnu!<CR>", { desc = "Toggle Relative number" })

    -- Select Current Line
    map("n", "<leader>v", "^vg_", { desc = "General Select current line" })

    -- Marks
    map("n", "<leader>mm", ":marks<Cr>", { desc = "General Show marks" })
    map("n", "<leader>md", ":delmarks a-zA-Z0-9<Cr>", { desc = "General Clear all marks" })

    -- Move Lines
    map("n", "<A-j>", ":m .+1<CR>==", { desc = "General Move line down" })
    map("n", "<A-k>", ":m .-2<CR>==", { desc = "General Move line up" })

    -- New Line
    map("n", "<leader>o", 'o<Esc>0"_D', { desc = "General Add newline below" })
    map("n", "<leader>O", 'O<Esc>0"_D', { desc = "General Add newline above" })

    -- Reselect Pasted
    map("n", "gp", "`[v`]", { desc = "General Reselect pasted in visual mode" })
    map("n", "gP", "`[V`]", { desc = "Genearal Reselect pasted in Visual line mode" })

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
    map("n", "<leader>X", "<cmd> w|%bd|e#|bd# <CR>", { desc = "Buffer close other buffers" })

    -- motion keys window resize
    vim.g.resize_keymaps_enabled = false

    local function toggleMotionResize()
        if vim.g.resize_keymaps_enabled then
            nomap("n", "h")
            nomap("n", "j")
            nomap("n", "k")
            nomap("n", "l")
            vim.g.resize_keymaps_enabled = false
        else
            map("n", "h", "<C-w>5<", { desc = "Window Increase width" })
            map("n", "j", "<C-w>5+", { desc = "Window Increase height" })
            map("n", "k", "<C-w>5-", { desc = "Window Decrease height" })
            map("n", "l", "<C-w>5>", { desc = "Window Decrease width" })
            vim.g.resize_keymaps_enabled = true
        end
    end

    _G.toggleMotionResize = toggleMotionResize
    vim.cmd([[command! ToggleMotionResize lua _G.toggleMotionResize()]])
    map("n", "<leader>tw", "<cmd>ToggleMotionResize<CR>", { desc = "Toggle Window motion resize" })

    ---- Existing Keybinds ----

    -- Quick Escape
    -- map("i", "jj", "<Esc>", { desc = "Quick Escape" })
    -- map("i", "jk", "<Esc>", { desc = "Quick Escape 2" })
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
    end, { buffer = buffer, desc = "Git Jump next hunk", expr = true })

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
    end, { buffer = buffer, desc = "Git Jump previous hunk", expr = true })

    -- preview hunk
    map("n", "<leader>hp", function()
        gs.preview_hunk()
    end, { buffer = buffer, desc = "Git Preview hunk" })

    -- stage hunk
    map("n", "<leader>hs", function()
        gs.stage_hunk()
    end, { buffer = buffer, desc = "Git Stage Hunk" })

    -- unstage hunk
    map("n", "<leader>hu", function()
        gs.undo_stage_hunk()
    end, { buffer = buffer, desc = "Git Unstage hunk" })

    -- reset hunk
    map("n", "<leader>hr", function()
        gs.reset_hunk()
    end, { buffer = buffer, desc = "Git Reset hunk" })

    -- diff hunk
    map("n", "<leader>hd", function()
        gs.diffthis()
    end, { buffer = buffer, desc = "Git Diff hunk" })

    -- stage selected hunk
    map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { buffer = buffer, desc = "Git Stage selected hunk" })

    -- unstage selected hunk
    map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { buffer = buffer, desc = "Git Reset selected hunk" })

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
        print("Harpoon " .. vim.fn.expand("%"))
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
    -- open neogit
    map("n", "<leader>gs", "<cmd>:wa|Neogit<CR>", { desc = "Git Open neogit" })
end

function M.diffview()
    -- toggle diff view
    map("n", "<leader>gd", function()
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        vim.cmd("wa")
        if view then
            vim.cmd.DiffviewClose()
        else
            vim.cmd.DiffviewOpen()
        end
    end, { desc = "Git Open diff view" })

    map("n", "<leader>gl", function()
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        if view then
            vim.cmd.DiffviewClose()
        else
            vim.cmd.DiffviewFileHistory()
        end
    end, { desc = "Git Open diff history" })
end

function M.telescope()
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
    map("n", "<leader>sl", "<cmd> Telescope git_commits <CR>", { desc = "Telescope Search git commits" })

    -- search git diffs
    nomap("n", "<leader>gt")
    map("n", "<leader>sd", "<cmd> Telescope git_status <CR>", { desc = "Telescope Search git diffs" })

    -- search marks
    map("n", "<leader>sm", "<cmd> Telescope marks <CR>", { desc = "Telescope bookmarks" })

    -- search neovim config
    map("n", "<leader>sn", function()
        local builtin = require("telescope.builtin")
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Telescope Search neovim configs" })

    -- search sessions
    map("n", "<leader>ss", "<cmd> Telescope session-lens <CR>", { desc = "Telescope sessions" })

    -- markdown headers
    map("n", "<leader>mh", "<cmd>Telescope heading<CR>", { desc = "Telescope markdown or docs headings" })
end

function M.obisidan()
    local newNotes = function()
        local title = vim.fn.input("Note title: ")
        if title == "" then
            print("no title given")
            return
        end
        vim.cmd("ObsidianNew " .. title)
        vim.schedule(function()
            vim.cmd("ObsidianTemplate note")
            vim.api.nvim_feedkeys('gg"_dd', "n", true)
        end)
    end

    -- workflow
    local obsidian_config = require("configs.obsidian")
    local vault = obsidian_config.vault

    map("n", "<leader>nD", function()
        if not obsidian_config.checkObsidian() then
            return
        end
        vim.cmd("tabnew")
        vim.cmd(vault)
        vim.cmd("ObsidianDailies")
    end, { desc = "Obsidian Create new daily note in new tab" })

    map("n", "<leader>nN", function()
        if not obsidian_config.checkObsidian() then
            return
        end
        vim.cmd("tabnew")
        vim.cmd(vault)
        newNotes()
    end, { desc = "Obsidian Create new note in new tab" })

    map("n", "<leader>nz", function()
        if not obsidian_config.checkObsidian() then
            return
        end
        return "<cmd>" .. vault .. "<CR>"
    end, { desc = "Obsidian cd to notes" })

    -- general
    -- TODO add obsidian directory check
    map("n", "<leader>nc", "<cmd>ObsidianNew<CR>", { desc = "Obsidian Create new note" })
    map("n", "<leader>nw", "<cmd>ObsidianWorkspace<CR>", { desc = "Obsidian Search workspaces" })
    map("n", "<leader>ns", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian Search notes" })
    map("n", "<leader>ng", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian Grep notes" })
    map("n", "<leader>nd", "<cmd>ObsidianDailies<CR>", { desc = "Obsidian List dailies" })
    map("n", "<leader>nn", newNotes, { desc = "Obsidian New templated note" })
end

function M.zenMode()
    map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "ZenMode Toggle zen mode" })
end

function M.setup()
    M.general()
    M.telescope()
    M.obisidan()
end

return M
