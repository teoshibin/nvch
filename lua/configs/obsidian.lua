local M = {}

M.vault = vim.fs.normalize(vim.fn.expand("~") .. "/obsidian")
M.cd_vault_cmd = "cd " .. M.vault

--- Check if obsidian directory exist on the system user directory
--- @param notify boolean|nil print message when, default to true
--- @return boolean true when folder exist
function M.checkDirectory(notify)
    local exist = require("custom.path").is_directory(M.vault)
    local warn = notify or true
    if not exist and warn then
        vim.notify("Obsidian Folder Doesn't exist", vim.log.levels.WARN)
    end
    return exist
end

M.opts = {
    workspaces = {
        {
            name = "personal",
            path = "~/obsidian",
        },
    },
    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",
    log_level = vim.log.levels.INFO,
    daily_notes = {
        folder = "notes/daily",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = "daily.md",
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
        ["<leader>n`"] = {
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

    map("n", "<leader>no", "<cmd>ObsidianOpen<CR>", { desc = "Obsidian Open obsidian" })
    map("n", "<leader>nt", "<cmd>ObsidianTemplate<CR>", { desc = "Obsidian Note template" })
    map("n", "<leader>nh", "<cmd>ObsidianTags<CR>", { desc = "Obsidian List hashtags" })
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
end

return M
