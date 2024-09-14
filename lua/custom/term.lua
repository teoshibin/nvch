local M = {}

-- Toggle NvChad terminal
local function toggle_term(term_opts)
    if require("custom.os").isWindows() then
        term_opts.cmd = vim.o.shell .. " -nol"
    end
    require("nvchad.term").toggle(term_opts)
end

function M.toggle_horizontal_term()
    toggle_term({ pos = "sp", id = "htoggleTerm", size = 0.3 })
end

function M.toggle_vertical_term()
    toggle_term({ pos = "vsp", id = "vtoggleTerm", size = 0.4 })
end

function M.toggle_floating_term()
    toggle_term({ pos = "float", id = "floatTerm" })
end

return M

