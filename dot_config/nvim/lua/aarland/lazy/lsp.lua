return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
        "j-hui/fidget.nvim",
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
        local capabilities = require("blink.cmp").get_lsp_capabilities();
        local neoconf = require("neoconf")

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = false,
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
            },
            handlers = {

                ["eslint"] = function()
                    local validate = "on"
                    if neoconf.get('eslint') == false then
                        validate = "off"
                    end
                    require("lspconfig").eslint.setup {
                        capabilities = capabilities,
                        settings = {
                            format = false,
                            run = "onSave",
                            validate = validate
                        }
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each", "require" },
                                }
                            }
                        }
                    }
                end,
                ["ts_ls"] = function()
                    local lspconfig = require("lspconfig")
                    if not neoconf.get('vue') then
                        lspconfig.ts_ls.setup {
                            capabilities = capabilities
                        }
                        return
                    end
                    lspconfig.ts_ls.setup({
                        init_options = {
                            plugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location =
                                    "/home/aaarland/.local/share/fnm/node-versions/v20.16.0/installation/lib/node_modules/@vue/typescript-plugin/",
                                    languages = { "javascript", "typescript", "vue" },
                                },
                            },
                        },
                        filetypes = { "typescript", "javascript", "vue", "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx" },
                    })
                end,
                ["volar"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.volar.setup({})
                end,
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            }
        })

        vim.lsp.config('*', {
            flags = {
                debounce = neoconf.get("lsp_debounce") or 150
            }
        })
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
    end
}
