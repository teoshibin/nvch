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
        alias_format = "%B %-d, %Y",
        template = "templates/daily.md",
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
        ["<leader>nc"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        ["<leader>na"] = {
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

    --[[
        ObsidianOpen           done
        ObsidianQuickSwitch    done
        ObsidianNew            done
        ObsidianFollowLink     
        ObsidianWorkspace      done
        ObsidianBacklinks      done
        ObsidianDailies        done
        ObsidianLink           
        ObsidianLinkNew        
        ObsidianLinks          done
        ObsidianSearch         done
        ObsidianPasteImg       done
        ObsidianRename         done
        ObsidianTemplate       done
        ObsidianToday          
        ObsidianTomorrow       
        ObsidianYesterday      
        ObsidianTags           done
    --]]
    local cdBrain = "cd " .. vim.fs.normalize(vim.fn.expand("~") .. "/brain<CR>")
    map("n", "<leader>Nt", "<cmd>tabnew | " .. cdBrain, { desc = "Obsidian Open notes in new tab" })
    map("n", "<leader>Nc", "<cmd>" .. cdBrain, { desc = "Obsidian cd to notes" })

    map("n", "<leader>no", "<cmd>ObsidianOpen<CR>", { desc = "Obsidian Open obsidian" })
    map("n", "<leader>nc", "<cmd>ObsidianNew<CR>", { desc = "Obsidian Create new note" })
    map("n", "<leader>nt", "<cmd>ObsidianTemplate<CR>", { desc = "Obsidian Note template" })
    map("n", "<leader>nw", "<cmd>ObsidianWorkspace<CR>", { desc = "Obsidian Search workspaces" })
    map("n", "<leader>ns", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Obsidian Search notes" })
    map("n", "<leader>ng", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian Grep notes" })
    map("n", "<leader>nh", "<cmd>ObsidianTags<CR>", { desc = "Obsidian List hashtags" })
    map("n", "<leader>nd", "<cmd>ObsidianDailies<CR>", { desc = "Obsidian List dailies" })
    map("n", "<leader>nl", "<cmd>ObsidianLinks<CR>", { desc = "Obsidian List links" })
    map("n", "<leader>nb", "<cmd>ObsidianBacklinks<CR>", { desc = "Obsidian Show backlinks" })
    map("n", "<leader>ni", "<cmd>ObsidianPasteImg<CR>", { desc = "Obsidian Paste image" })
    map("n", "<leader>nr", function()
        local name = vim.fn.input("Rename note: ")
        local wet = vim.fn.input("Wet run (y/n): ")
        local dryOption = ""
        if name == "" then
            print("no name given")
            return
        elseif wet == "" or wet == "n" then
            dryOption = " --dry-run"
            return
        end
        vim.cmd("ObisidianRename " .. name .. dryOption)
    end, { desc = "Obisidian Rename file link" })
    map("v", "<leader>ne", function()
        local title = vim.fn.input("Extract note title: ")
        if title == "" then
            print("no title given")
            return
        end
        vim.cmd("ObsidianExtractNote " .. title)
    end, { desc = "Obisidan Extract to new note" })
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
    end, { desc = "Obsidian New templated note" })
end

return M
