return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
        "folke/neoconf.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },

    config = function()
        -- require("fidget").setup({})
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local neoconf = require("neoconf")
        vim.lsp.config('*', {
            capabilities = capabilities
        })
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_enable = {
                exclude = {
                    "eslint"
                }
            },
            automatic_installation = false,
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
            },
        })

        vim.lsp.enable('eslint', neoconf.get('eslint') ~= false and not neoconf.get('eslint_d'))

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })
        require("aarland.lint")
    end
}
