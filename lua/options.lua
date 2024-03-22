require("nvchad.options")

local opt = vim.opt
local g = vim.g

--[[

  NOTE: Options that exist in default nvchad config are commentted  
  See :help vim.opt
  See :help option-list

--]]

-- Leader Key
-- g.mapleader = ' '
-- g.maplocalleader = ' '

-- Line numbers & relative line numbers
-- opt.number = true
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- opt.mouse = "a"

-- Don't show the mode, since it's already in status line
-- opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- opt.clipboard = "unnamedplus"

-- Enable break indent for wrapped lines
opt.breakindent = true

-- Save undo history
-- vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
-- opt.ignorecase = true
-- opt.smartcase = true

-- Keep signcolumn on by default
-- opt.signcolumn = "yes"

-- Decrease update time
-- opt.updatetime = 250
opt.timeoutlen = 350

-- Configure how new splits should be opened
-- opt.splitright = true
-- opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 8

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- opt.hlsearch = true

-- tab size
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Make the jump-list behave like the tag list or a web browser.
opt.jumpoptions = "stack"

-- Max char line (not transparent)
opt.colorcolumn = { 80 }

-- Change terminal shell, See :h shell-powershell
if require("custom.os").isWindows() then
    local shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.o.shell = shell
    -- NOTE: this broke neogit for some reason
    -- vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command "
    --     .. "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
    --     .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
    vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
    vim.o.shellredir = '2>&1 | %{"$(_)" } | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | %{"$(_)" } | Tee-Object %s; exit $LastExitCode'
    vim.o.shellquote = ""
    vim.o.shellxquote = ""

    -- Some random snippets I found online
    -- shell=powershell.exe
    -- set shellxquote=
    -- let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    -- let &shellquote   = ''
    -- let &shellpipe    = '| Out-File -Encoding UTF8 %s'
    -- let &shellredir   = '| Out-File -Encoding UTF8 %s'
end
