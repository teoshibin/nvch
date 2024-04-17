local dap = require("dap")
local dapui = require("dapui")
local map = require("mappings").map

-- dap.setup()
-- dapui.setup({})

-- dap ui

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- dap

map("n", "<F5>", dap.continue, { desc = "debugger continue" })
map("n", "<F10>", dap.step_over, { desc = "debugger step over" })
map("n", "<F11>", dap.step_into, { desc = "debugger step into" })
map("n", "<F12>", dap.step_out, { desc = "debugger step out" })

map("n", "<Leader>b", dap.toggle_breakpoint, { desc = "debugger toggle breakpoint" })
map("n", "<Leader>B", dap.set_breakpoint, { desc = "debugger set breakpoint" })
map("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")), { desc = "log point" })

map("n", "<Leader>dr", dap.repl.open, { desc = "debugger open repl" })
map("n", "<Leader>dl", dap.run_last, { desc = "debugger rerun last debugger" })

map({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "debugger hover" })
map({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview, { desc = "debugger preview" })

map("n", "<Leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames)
end, { desc = "debugger frames" })

map("n", "<Leader>ds", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end, { desc = "debugger scopes" })

