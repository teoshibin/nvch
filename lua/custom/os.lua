local M = {}

local uname = vim.loop.os_uname()
local os = uname.sysname
local isMac = os == "Darwin"
local isLinux = os == "Linux"
local isWindows = os:find("Windows") and true or false
local isWSL = isLinux and uname.release:find("Microsoft") and true or false

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

return M
