
local M = {}

function M.is_nil(value)
    return type(value) == "nil"
end

function M.is_number(value)
    return type(value) == "number"
end

function M.is_string(value)
    return type(value) == "string"
end

function M.is_boolean(value)
    return type(value) == "boolean"
end

function M.is_table(value)
    return type(value) == "table"
end

function M.is_list(value)
    if type(value) ~= "table" then return false end
    local i = 0
    for k in pairs(value) do
        i = i + 1
        if type(k) ~= "number" or k ~= i then return false end
    end
    return true
end

function M.is_function(value)
    return type(value) == "function"
end

function M.is_thread(value)
    return type(value) == "thread"
end

function M.is_userdata(value)
    return type(value) == "userdata"
end

return M
