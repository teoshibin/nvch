
local M = {}

local checker = require("custom.type")
local is_list = checker.is_list
local is_table = checker.is_table

-- Clones a value, recursively copying tables
local function clone(v)
    if is_table(v) then
        local result = {}
        for k, val in pairs(v) do
            result[k] = clone(val)
        end
        return result
    else
        return v
    end
end

-- Merges tables and concatenating lists when appropriate
function M.merge(t1, t2)
    local result = clone(t1)
    for k, v in pairs(t2) do
        if is_table(result[k]) and is_table(v) then
            if is_list(result[k]) and is_list(v) then
                local new_list = {}
                for _, val in ipairs(result[k]) do
                    table.insert(new_list, clone(val))
                end
                for _, val in ipairs(v) do
                    table.insert(new_list, clone(val))
                end
                result[k] = new_list
            else
                result[k] = M.merge(result[k], v)
            end
        else
            result[k] = clone(v)
        end
    end
    return result
end

return M
