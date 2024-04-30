local M = {}

M.opts = {
    workspaces = {
        {
            name = "personal",
            path = "~/brain",
        },
    },
    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",
    log_level = vim.log.levels.INFO,
    daily_notes = {
        folder = "notes/daily",
        date_format = "%Y-%m-%d",
        -- alias_format = "%B %-d, %Y",
        template = "daily",
    },
    disable_frontmatter = true,
    attachments = {
        img_folder = "assets/images",
    },
    templates = {
        subdir = "templates",
    },
    mappings = {
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ic"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        ["<leader>ia"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        },
    },

    ---@param title string|?
    ---@return string
    note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a date and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '2023-04-28_my-new-note.md'
        local os_date = os.date("*t") -- Get table with year, month, day etc.
        local formatted_date = string.format("%04d-%02d-%02d", os_date.year, os_date.month, os_date.day)

        local suffix = ""
        if title ~= nil then
            -- If title is given, transform it into a valid file name.
            suffix = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower() -- improved regex to handle non-alphanumeric and whitespace correctly
        else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            math.randomseed(os.time()) -- Seed the random number generator to make it less predictable
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return formatted_date .. "_" .. suffix .. ".md"
    end,
}

M.setup = function()
    vim.opt.conceallevel = 2
    require("obsidian").setup(M.opts)
    local map = require("mappings").map

    map("n", "<leader>nc", "<cmd>ObsidianNew<CR>", { desc = "Obsidian New note" })
    map("n", "<leader>nt", "<cmd>ObsidianTemplate<CR>", { desc = "Obsidian Note template" })
    map("n", "<leader>nn", function()
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
    end)
end

return M
