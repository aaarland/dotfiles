return {
    'stevearc/conform.nvim',
    opts = {
        default_format_opts = { lsp_format = "fallback" },
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofmt" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            html = { "prettier" },
            markdown = { "prettier" },
            ["markdown.mdx"] = { "prettier" }
        }
    },
}
