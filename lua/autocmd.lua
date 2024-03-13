-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--  Callback is called when the post yank event occurs
autocmd("TextYankPost", {
    desc = "Highlight when copying text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Auto create parent directories when writing new file using :e command
-- :help ++p
-- " Auto-create parent directories (except for URIs "://").
-- au BufWritePre,FileWritePre * if @% !~# '\(://\)' | call mkdir(expand('<afile>:p:h'), 'p') | endif
autocmd({ "BufWritePre" }, {
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- -- NOTE: fix nvimtree buffer layout for auto-session
-- -- https://github.com/NvChad/ui/issues/132
-- autocmd({ "BufEnter" }, {
--   pattern = "NvimTree*",
--   callback = function()
--     local api = require "nvim-tree.api"
--     local view = require "nvim-tree.view"
--     if not view.is_visible() then
--       api.tree.open()
--     end
--   end,
-- })
