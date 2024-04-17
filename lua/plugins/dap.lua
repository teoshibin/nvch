return {
    {
        "rcarriga/nvim-dap-ui",
        lazy = false, -- TODO: remove this
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require("dap").setup()
            require("dapui").setup()
            require("configs.dap")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {}
    },
}
