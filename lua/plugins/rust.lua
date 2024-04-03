return {
    {
        -- NOTE: rustaceanvim does not use Mason's installation of rust-analyzer
        -- Instal rust-analyzer:
        -- `rustup component add rust-analyzer`
        -- doc: https://rust-analyzer.github.io/manual.html#rustup
        -- 
        -- NOTE: to use mason we could do the following (currently not configured)
        -- issue: https://github.com/mrcjkb/rustaceanvim/issues/258
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
        lazy = false,
        config = function()
            local lspconfig = require("configs.nvchad_lspconfig")
            local map = vim.keymap.set
            vim.g.rustaceanvim = {
                tools = {},
                server = {
                    on_attach = function(client, bufnr)
                        local function opts(desc)
                            return { buffer = bufnr, desc = desc }
                        end

                        -- lsp
                        lspconfig.on_attach()
                        map({ "n", "v" }, "<leader>ca", vim.cmd.RustLsp("codeAction"), opts("Lsp Code action"))

                        -- tools
                        map("n", "J", vim.cmd.RustLsp("joinLines"), opts("General join line"))
                    end,
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ["rust-analyzer"] = {},
                    },
                },
                dap = {},
            }
        end,
    },
}
