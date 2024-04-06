-- NOTE: :help conform-formatters
-- :Mason for installing formatters
return {
    lsp_fallback = true,

    -- formatters by filetype
    formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        markdown = { "markdownlint" },
        python = { "ruff" },
        kotlin = { "ktlint" },
        java = { "google-java-format" },
    },
}
