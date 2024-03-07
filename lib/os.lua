local M = {}

local uname = vim.loop.os_uname()
local os = uname.sysname
local isMac = os == "Darwin"
local isLinux = os == "Linux"
local isWindows = os:find "Windows" and true or false
local isWSL = isLinux and uname.release:find "Microsoft" and true or false

function M.name()
  return os
end

function M.isMac()
  return isMac
end

function M.isLinux()
  return isLinux
end

function M.isWindows()
  return isWindows
end

function M.isWSL()
  return isWSL
end

M.pathSep = "/"
if M.isWindows() then
  M.pathSep = "\\"
end

---Split string into a table of strings using a separator.
---@param inputString string The string to split.
---@param sep string The separator to use.
---@return table table A table of strings.
M.split = function(inputString, sep)
  local fields = {}

  local pattern = string.format("([^%s]+)", sep)
  local _ = string.gsub(inputString, pattern, function(c)
    fields[#fields + 1] = c
  end)

  return fields
end

---Joins arbitrary number of paths together.
---@param ... string The paths to join.
---@return string
M.pathJoin = function(...)
  local args = {...}
  if #args == 0 then
    return ""
  end

  local all_parts = {}
  if type(args[1]) =="string" and args[1]:sub(1, 1) == M.pathSep then
    all_parts[1] = ""
  end

  for _, arg in ipairs(args) do
    local arg_parts = M.split(arg, M.pathSep)
    vim.list_extend(all_parts, arg_parts)
  end
  return table.concat(all_parts, M.pathSep)
end

return M
