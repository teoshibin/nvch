local M = {}

local platform = require("custom.os")

M.seperator = platform.isWindows() and "\\" or "/"

-- local function escape(s)
--     return (s:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0"))
-- end

function M.current_buffer()
    -- local path = vim.fn.expand("%")
    -- local cwd = vim.loop.cwd()
    -- cwd = string.lower(string.sub(cwd, 1, 1)) .. string.sub(cwd, 2) .. M.seperator
    -- return path:gsub(cwd, "")
    return vim.fn.expand("%")
end

-- --- Check if file exist
-- ---@param path string filepath
-- ---@return boolean true if exist
-- function M.file_exist(path)
--     local file = io.open(path, "r")
--     if file then
--         file:close()
--         return true
--     else
--         return false
--     end
-- end

--- This will check if path.lua is in this specific directory
---@return boolean true if path.lua is found, thus it must the config file
function M.is_config()
    local cwd = vim.loop.cwd()
    local cfg = vim.fn.stdpath("config")
    return #cwd:gsub(cfg, "") == 0 and #cfg:gsub(cwd, "") == 0
end

-- -- Filepath relative to currently working directory
-- -- @param value int|string|nil Path string, buffer number or nil
-- -- @return string string Currently working filepath relative to cwd.
-- function M.cwdPath(value)
--     local filePath = ""
--     if type(value) == "number" then
--         filePath = vim.api.nvim_buf_get_name(value)
--     elseif type(value) == "string" then
--         filePath = value
--     else
--         filePath = vim.fn.expand("%")
--     end
--     local pattern = escape(vim.loop.cwd() .. M.seperator)
--     return string.gsub(filePath, pattern, "")
-- end

---Split string into a table of strings using a separator.
---@param inputString string The string to split.
---@param sep string|nil The separator to use. defualt to os specific seperator.
---@return table table A table of strings.
function M.split(inputString, sep)
    local fields = {}
    sep = sep or M.seperator
    local pattern = string.format("([^%s]+)", sep)
    local _ = string.gsub(inputString, pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end

-- TODO: could be replaced with vim.fs.normalize()
---Joins arbitrary number of paths together.
---@param ... string The paths to join.
---@return string
function M.join(...)
    local args = { ... }
    if #args == 0 then
        return ""
    end
    local all_parts = {}
    if type(args[1]) == "string" and args[1]:sub(1, 1) == M.seperator then
        all_parts[1] = ""
    end
    for _, arg in ipairs(args) do
        local arg_parts = M.pathSplit(arg)
        vim.list_extend(all_parts, arg_parts)
    end
    return table.concat(all_parts, M.seperator)
end

return M
