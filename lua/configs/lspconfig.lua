local configs = require("nvchad.configs.lspconfig")

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local os = require("custom.os")
-- TODO: create a function that will add string into table based on condition
-- instead of using an additional `install_condition` field

local lspconfig = require("lspconfig")
local servers = {
    ["tsserver"] = {},
    ["clangd"] = {},
    ["powershell_es"] = {
        install_condition = os.isWindows(),
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
    },
    ["marksman"] = {},
    ["pyright"] = {},
    ["kotlin_language_server"] = {},
    ["jdtls"] = {},
}

-- NOTE: if you just want default config for the servers then put them in a table
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

for lsp, mods in pairs(servers) do
    local install = vim.tbl_get(mods, "install_condition")
    if install ~= nil and not install then
        goto continue
    end

    local defaults = {
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
    }
    local opts = vim.tbl_deep_extend("force", defaults, mods)
    lspconfig[lsp].setup(opts)

    ::continue::
end

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_init = on_init,
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

-- Without the loop, you would have to manually set up each LSP
--
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
