local M = {}

local platform = require("custom.os")

M.seperator = platform.isWindows() and "\\" or "/"

--- This will check if path.lua is in this specific directory
---@return boolean true if path.lua is found, thus it must the config file
function M.is_config()
    local cwd = vim.loop.cwd()
    local cfg = vim.fn.stdpath("config")
    return #cwd:gsub(cfg, "") == 0 and #cfg:gsub(cwd, "") == 0
end

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

--- Check if path is directoy
--- @param path string Directory path
--- @return boolean true if path is directory
function M.is_directory(path)
    local info = vim.loop.fs_stat(path)
    return info and info.type == "directory" or false
end

return M
