-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- default was "nvchad.configs.lspconfig"
local target_config = "configs.nvchad_lspconfig"
local on_attach = require(target_config).on_attach
local on_init = require(target_config).on_init
local capabilities = require(target_config).capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local servers = {
    "tsserver",
    "clangd",
    "marksman",
    "pyright",
    "jdtls",
    -- "perl_language_server",
}

local defaults = {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
}

local function config(mods)
    return vim.tbl_deep_extend("force", defaults, mods)
end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(defaults)
end

lspconfig.powershell_es.setup(config({
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
}))

-- https://github.com/fwcd/kotlin-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/kotlin_language_server.lua
-- Doesn't work very well, slow as fuck
lspconfig.kotlin_language_server.setup(config({
    root_dir = function(fname)
        local root = util.root_pattern(unpack({
            "settings.gradle", -- Gradle (multi-project)
            "settings.gradle.kts", -- Gradle (multi-project)
            "build.xml", -- Ant
            "pom.xml", -- Maven
            "build.gradle", -- Gradle
            "build.gradle.kts", -- Gradle
        }))(fname)
        if root then
            return root
        end
        return util.find_git_ancestor(fname)
    end,
    single_file_support = true,
    cmd = { "kotlin-language-server" },
    settings = {},
    init_options = {
        -- storagePath = kt_root_dir(vim.fn.expand("%:p:h")),
        -- provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { "html", "css", "javascript" },
    },
}))

