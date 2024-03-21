return {
    {
        "stevearc/conform.nvim",
        opts = require("configs.conform"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            -- NOTE: fix uv_dlopen treesitter error on windows
            -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#llvm-clang
            --
            -- Troubleshooting:
            --  1. Install compilers as mentioned by treesitter page
            --  2. Restart terminal if needed
            --  3. Delete any mason and treesitter related folders in nvim `*-data` folder
            --  4. TSInstall if needed

            if require("custom.os").isWindows() then
                require("nvim-treesitter.install").compilers = { "clang" }
            end

            local defaults = require("nvchad.configs.treesitter")
            local configs = require("configs.treesitter")
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function()
            local defaults = require("nvchad.configs.mason")
            local configs = require("configs.mason")
            return vim.tbl_deep_extend("force", defaults, configs)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
    {
        -- override completion keybinds
        "hrsh7th/nvim-cmp",
        opts = function()
            local defaults = require("nvchad.configs.cmp")
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- NOTE: Overriding insertion behavior (insert when accepted)
            defaults.completion = {
                completeopt = "menu,menuone,noinsert",
            }

            -- NOTE: Overriding code completion keybinds

            -- Accept snippet (tab or C-y)
            -- local accept = {
            --   behavior = cmp.ConfirmBehavior.Insert,
            --   select = true,
            -- }
            defaults.mapping["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
            defaults.mapping["<Tab>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
            defaults.mapping["<S-Tab>"] = nil

            -- Jump to different placeholder location of the snippet
            defaults.mapping["<C-l>"] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" })

            defaults.mapping["<C-h>"] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" })

            return defaults
        end,
    },
}
