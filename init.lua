local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------

--[[
  See :help vim.opt
  See :help option-list
  NOTE: Options that exist in default nvchad config are commentted  
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
opt.timeoutlen = 300

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
-- opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 8

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- opt.hlsearch = true

-- tab size
opt.shiftwidth = 4

if require("custom.lib.os").isWindows() then
  -- See :h shell-powershell
  -- Check if pwsh (PowerShell Core) is available (online), otherwise use 'powershell' (builtin)
  local shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
  -- Set the shell to use
  vim.o.shell = shell
  -- Set shell flags for command execution
  vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command "
    .. "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
    .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
  -- Set shell redirection
  vim.o.shellredir = '2>&1 | %{"$(_)" } | Out-File %s; exit $LastExitCode'
  -- Set shell pipe
  vim.o.shellpipe = '2>&1 | %{"$(_)" } | Tee-Object %s; exit $LastExitCode'
  -- Unset shellquote and shellxquote
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

-------------------------------------- autocmds ------------------------------------------
-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--  Callback is called when the post yank event occurs
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when copying text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto create parent directories when writing new file
-- :help ++p
-- " Auto-create parent directories (except for URIs "://").
-- au BufWritePre,FileWritePre * if @% !~# '\(://\)' | call mkdir(expand('<afile>:p:h'), 'p') | endif
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function(event)
    if event.match:match "^%w%w+://" then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
