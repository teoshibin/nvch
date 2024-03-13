local M = {}

-- Create a nice message.
-- @param msg string message.
-- @param opts table|nil if time is true print time.
-- @return string nice message.
function M.msgStr(msg, opts)
    opts = opts or {}
    local time = ""
    if opts.time then
        time = vim.fn.strftime("[%H:%M:%S] ")
    end
    return time .. msg
end

-- Print a nice message.
-- @param msg string message.
-- @param opts table|nil if time is true print time.
function M.msg(msg, opts)
    print(M.msgStr(msg, opts))
end

return M
