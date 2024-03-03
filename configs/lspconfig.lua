local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  ["tsserver"] = {},
  ["clangd"] = {},
  ["powershell_es"] = {
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/"
  },
}

for lsp, mods in pairs(servers) do
  local defaults = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  local opts = vim.tbl_deep_extend("force", defaults, mods)
  lspconfig[lsp].setup(opts)
end

