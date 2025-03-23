return {
    {
        -- NOTE: Rustaceanvim does not use Mason's installation of rust-analyzer
        -- Install rust-analyzer: `rustup component add rust-analyzer`
        -- doc: https://rust-analyzer.github.io/manual.html#rustup

        -- NOTE: to use mason we could do the following (currently not configured)
        -- docs: `:h rustaceanvim.mason`

        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false, -- This plugin is already lazy
        config = function()
            local lspconfig = require("configs.nvlspconfig")
            local map = vim.keymap.set
            vim.g.rustaceanvim = {
                -- tools = {},
                server = {
                    on_attach = function(_, bufnr)
                        local function opts(desc)
                            return { buffer = bufnr, desc = desc }
                        end

                        -- default lsp keymaps
                        lspconfig.on_attach(_, bufnr)

                        -- code action
                        map({ "n", "v" }, "<leader>a", function()
                            vim.cmd.RustLsp("codeAction")
                        end, opts("Lsp Code action"))
                        map({ "n", "v" }, "<A-CR>", function()
                            vim.cmd.RustLsp("codeAction")
                        end, opts("Lsp Code action"))

                        -- join line
                        map("n", "J", function()
                            vim.cmd.RustLsp("joinLines")
                        end, opts("Lsp Rust join line"))

                        -- show diagnostic pop up
                        map("n", "<leader>eR", function()
                            vim.cmd.RustLsp({ "renderDiagnostic", "current" })
                        end, opts("Lsp Rust show diagnostic"))
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            procMacro = {
                                enable = true,
                            },
                            diagnostics = {
                                experimental = {
                                    enable = true,
                                },
                            },
                        },
                    },
                },
                -- dap = {},
            }
        end,
    },
    {
        "teoshibin/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        branch = "powershell-install-cmd-fix",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
