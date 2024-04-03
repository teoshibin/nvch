-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- local target_config = "nvchad.configs.lspconfig"
local target_config = "configs.nvchad_lspconfig" -- was copied over to customize keymaps

local on_attach = require(target_config).on_attach
local on_init = require(target_config).on_init
local capabilities = require(target_config).capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local function defaults(mods)
    return vim.tbl_deep_extend("force", {
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
    }, mods)
end

---- Auto Config ----

local servers = {
    "tsserver",
    "clangd",
    "marksman",
    "pyright",
    "jdtls",
    -- "perl_language_server",
    -- "rust_analyzer", -- See ../plugins/rust.lua
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(defaults({}))
end

---- Manual Configuration ----

-- powershell --

lspconfig.powershell_es.setup(defaults({
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
}))

-- kotlin --

-- https://github.com/fwcd/kotlin-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/kotlin_language_server.lua
-- Doesn't update immediately after escape, sometimes require to escape multiple times for it to detect the changes
-- Install java, kotlin, gradle (probably not required) and the server itself through mason
local function kt_root_dir(filename)
    local norm_name = vim.fs.normalize(filename)
    return util.root_pattern(unpack({
        "settings.gradle", -- Gradle (multi-project)
        "settings.gradle.kts", -- Gradle (multi-project)
        "build.xml", -- Ant
        "pom.xml", -- Maven
        "build.gradle", -- Gradle
        "build.gradle.kts", -- Gradle
        ".git",
    }))(norm_name)
end
lspconfig.kotlin_language_server.setup(defaults({
    root_dir = kt_root_dir,
    single_file_support = true,
    cmd = { "kotlin-language-server" },
    settings = {},
    init_options = {
        storagePath = kt_root_dir(vim.fn.expand("%:p:h")),
        -- provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { "html", "css", "javascript" },
    },
}))
