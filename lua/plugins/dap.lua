return {
    {
        "theHamsta/nvim-dap-virtual-text",
        -- lazy = false,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "rcarriga/nvim-dap-ui",
        -- lazy = false,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            --[[
                There are 3 main components in order to make debugging work.

                dap: A debug adapter protocol client, a layer between neovim 
                     and lang dap, similar to lsp client where the only 
                     difference is that neovim has lsp client built in, but not
                     for dap client.

                lang dap: Specific to a language, a layer between dap client and
                          language specific debugger, act as an interface for 
                          dap to understand language specific debugger.

                debugger: The debugger itself provided by the language or
                          external sources.
            --]]

            local dapui = require("dapui")
            local dap = require("dap")
            local mappings = require("mappings")
            local map = mappings.map

            dofile(vim.g.base46_cache .. "dap")
            dapui.setup()

            -- dap ui

            -- see :help dap-extensions
            -- auto open and close dap ui using dap events
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

            -- map("n", "<F5>", function()
            --     dap.continue()
            -- end, { desc = "debugger continue" })
            map("n", "<leader>dc", function()
                dap.continue()
            end, { desc = "debugger continue" })

            -- map("n", "<F6>", function()
            --     dap.terminate()
            -- end, { desc = "debugger stop" })
            map("n", "<leader>dx", function()
                dap.terminate()
            end, { desc = "debugger stop" })

            -- map("n", "<F7>", function()
            --     dap.step_over()
            -- end, { desc = "debugger step over" })
            map("n", "<leader>do", function()
                dap.step_over()
            end, { desc = "debugger step over" })

            -- map("n", "<F8>", function()
            --     dap.step_into()
            -- end, { desc = "debugger step into" })
            map("n", "<leader>di", function()
                dap.step_into()
            end, { desc = "debugger step into" })

            -- map("n", "<F9>", function()
            --     dap.step_out()
            -- end, { desc = "debugger step out" })
            map("n", "<leader>du", function()
                dap.step_out()
            end, { desc = "debugger step out" })

            -- map("n", "<F10>", function()
            --     dap.toggle_breakpoint()
            -- end, { desc = "debugger toggle breakpoint" })
            map("n", "<Leader>bb", function()
                dap.toggle_breakpoint()
            end, { desc = "debugger toggle breakpoint" })

            -- map("n", "<Leader>B", function()
            --     dap.set_breakpoint()
            -- end, { desc = "debugger set breakpoint" })

            -- break and message
            map("n", "<Leader>bm", function()
                local message = vim.fn.input("Break message (str): ")
                dap.set_breakpoint(nil, nil, message)
            end, { desc = "debugger set logpoint" })

            -- break on condition
            map("n", "<Leader>bc", function()
                local condition = vim.fn.input("Break condition (expr): ")
                dap.set_breakpoint(condition, nil, nil)
            end, { desc = "debugger set logpoint" })

            -- break on N hits
            map("n", "<Leader>bh", function()
                local occurrence = vim.fn.input("Break hit (int): ")
                dap.set_breakpoint(nil, occurrence, nil)
            end, { desc = "debugger set logpoint" })

            -- clear all breakpoints
            map("n", "<leader>bx", function()
                dap.clear_breakpoints()
            end, { desc = "debugger clear all breakpoints" })

            -- quick fix list of breakpoints
            map("n", "<leader>bq", function()
                dap.list_breakpoints()
            end, { desc = "debugger quickfix list breakpoints" })

            -- map("n", "<Leader>dr", function()
            --     dap.repl.open()
            -- end, { desc = "debugger repl open" })

            map("n", "<Leader>dr", function()
                dap.run_last()
            end, { desc = "debugger run last debug adapter" })

            -- map({ "n", "v" }, "<Leader>dh", function()
            --     require("dap.ui.widgets").hover()
            -- end, { desc = "debugger hover" })
            --
            -- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
            --     require("dap.ui.widgets").preview()
            -- end, { desc = "debugger preview" })
            --
            -- vim.keymap.set("n", "<Leader>df", function()
            --     local widgets = require("dap.ui.widgets")
            --     widgets.centered_float(widgets.frames)
            -- end, { desc = "debugger preview frames" })
            --
            -- vim.keymap.set("n", "<Leader>ds", function()
            --     local widgets = require("dap.ui.widgets")
            --     widgets.centered_float(widgets.scopes)
            -- end, { desc = "debugger preview scopes" })

            map("n", "<Leader>dh", function()
                dapui.eval()
            end, { desc = "debugger evaluate under cursor" })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        -- lazy = false,
        dependencies = {
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local oslib = require("custom.os")
            local pypath = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv"
            if oslib.isWindows() then
                pypath = pypath .. "/Scripts/python.exe"
            else
                pypath = pypath .. "/bin/python"
            end
            require("dap-python").setup(vim.fs.normalize(pypath))
        end,
    },
}
