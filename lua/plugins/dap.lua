return {
    -- {
    --     -- see :DapInstall :DapUninstall
    --     "jay-babu/mason-nvim-dap.nvim",
    --     lazy = false,
    --     dependencies = {
    --         "williamboman/mason.nvim",
    --         "mfussenegger/nvim-dap",
    --     },
    --     config = function()
    --         require("mason").setup()
    --         require("mason-nvim-dap").setup({
    --             automatic_installtion = true,
    --             ensure_installed = {
    --                 "python",
    --             }
    --         })
    --     end
    -- },
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = false,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = false,
        -- keys = { "<F5>", "<leader>b", "<leader>B" },
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
            map("n", "<F5>", function()
                dap.continue()
            end, { desc = "debugger continue" })

            map("n", "<leader>dx", function()
                dap.terminate()
            end, { desc = "debugger stop" })

            map("n", "<F7>", function()
                dap.step_over()
            end, { desc = "debugger step over" })

            map("n", "<F8>", function()
                dap.step_into()
            end, { desc = "debugger step into" })

            map("n", "<F9>", function()
                dap.step_out()
            end, { desc = "debugger step out" })

            map("n", "<Leader>b", function()
                dap.toggle_breakpoint()
            end, { desc = "debugger toggle breakpoint" })

            map("n", "<Leader>B", function()
                dap.set_breakpoint()
            end, { desc = "debugger set breakpoint" })

            map("n", "<Leader>lp", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end, { desc = "debugger set logpoint" })

            map("n", "<Leader>dr", function()
                dap.repl.open()
            end, { desc = "debugger repl open" })

            map("n", "<Leader>dl", function()
                dap.run_last()
            end, { desc = "debugger run last debug adapter" })

            map({ "n", "v" }, "<Leader>dh", function()
                require("dap.ui.widgets").hover()
            end, { desc = "debugger hover" })

            vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
                require("dap.ui.widgets").preview()
            end, { desc = "debugger preview" })

            vim.keymap.set("n", "<Leader>df", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.frames)
            end, { desc = "debugger preview frames" })

            vim.keymap.set("n", "<Leader>ds", function()
                local widgets = require("dap.ui.widgets")
                widgets.centered_float(widgets.scopes)
            end, { desc = "debugger preview scopes" })
        end,
    },
    {
        -- NOTE: it is recommended to use system debugpy
        -- :!pip install debugpy
        "mfussenegger/nvim-dap-python",
        lazy = false,
        dependencies = {
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local oslib = require("custom.os")
            local pypath = ""
            if oslib.isWindows() then
                pypath = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/Scripts/python")
            else
                error("debugpy venv python path not specified!")
            end
            require("dap-python").setup(pypath)
        end,
    },
}
