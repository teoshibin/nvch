return {
    {
        "stevearc/conform.nvim",
        opts = function()
            require("mappings").conform()
            return require("configs.conform")
        end,
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
        "neovim/nvim-lspconfig",
        -- dependencies = {
        --     "williamboman/mason.nvim",
        --     "williamboman/mason-lspconfig.nvim",
        -- },
        config = function()
            -- disabled nvchad default config
            -- require("nvchad.configs.lspconfig").defaults()
            require("configs.nvlspconfig").defaults()
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
            local mods = {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = {
                    -- all enter, tab and C-y accept completion
                    ["<C-y>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                    -- disable select previous completion defined by nvchad
                    ["<S-Tab>"] = nil,
                    -- Jump to next placeholder location of the snippet
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    -- Jump to previous placeholder location of the snippet
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                },
            }
            return vim.tbl_deep_extend("force", defaults, mods)
        end,
    },
    {
        "folke/trouble.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function(_, opts)
            require("trouble").setup(opts)
            require("mappings").trouble()
        end,
    },
    {
        "stevearc/aerial.nvim",
        config = function()
            local map = require("mappings").map
            require("aerial").setup({
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    map("n", "[f", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    map("n", "]f", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            })
            -- You probably also want to set a keymap to toggle aerial
            map("n", "<leader>ea", "<cmd>AerialToggle<CR>")
        end,
    },
}
