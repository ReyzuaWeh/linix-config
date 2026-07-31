require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        python = { "black" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
