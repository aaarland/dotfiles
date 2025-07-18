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
    end
}
