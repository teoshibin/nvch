-- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Copied from nvchad to customize keymaps
local nvlsp = require("configs.nvlspconfig")
local on_attach = nvlsp.on_attach
local on_init = nvlsp.on_init
local capabilities = nvlsp.capabilities

local lspconfig = require("lspconfig")

local function defaults(mods)
    return vim.tbl_deep_extend("force", {
        on_init = on_init,
        on_attach = on_attach,
        capabilities = capabilities,
    }, mods)
end

-- Auto Server Configuration
local servers = {
    "marksman", -- markdown
    "ltex", -- grammar check
    "jdtls", -- java
    "basedpyright", -- python
    "gdshader_lsp", -- TODO
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(defaults({}))
end

lspconfig.ltex.setup(defaults({
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/ltex-ls" },
    settings = {
        ltex = {
            language = "en-GB",
        },
    },
}))

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
    local util = require("lspconfig.util")
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

local port = os.getenv("GDScript_Port") or "6005"
local nc_ex = require("custom.os").isWindows() and "ncat" or "nc"
lspconfig.gdscript.setup(defaults({
    -- Note: install windows netcat: https://nmap.org/download.html
    cmd = { nc_ex, "localhost", port },
}))

-- perl --

--[[
    1. perlpls
    https://github.com/FractalBoy/perl-language-server
    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#perlpls

    2. perlls Perl::LangugageServer
    https://github.com/richterger/Perl-LanguageServer/tree/master/clients/vscode/perl
    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#perlls

    3. PerlNavigator
    https://github.com/bscan/PerlNavigator
    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#perlnavigator
--]]
