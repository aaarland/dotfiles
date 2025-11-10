local capabilities = require('blink.cmp').get_lsp_capabilities()
local neoconf = require('neoconf')

vim.lsp.config('*', {
    capabilities = capabilities
})

vim.lsp.config('eslint', {
    settings = {
        format = false,
        run = "onSave",
    }
});

vim.lsp.config('bright_script', {
    filetypes = { 'brs', 'brightscript' }
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "it", "describe", "before_each", "after_each", "require" },
            }
        }
    }
})

if neoconf.get('vue') then
    vim.lsp.config('ts_ls', {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location =
                    "/home/adrian/.local/share/fnm/node-versions/v20.19.0/installation/lib/node_modules/@vue/typescript-plugin/",
                    languages = { "javascript", "typescript", "vue" },
                },
            },
        },
        filetypes = { "typescript", "javascript", "vue", "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx" },
    })
end

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

vim.lsp.config('intelephense', {
        settings = {
        intelephense = {
            environment = {
                includePaths = {
                    "/home/adrian/code/phpApi/moxie-global/",
                    "/home/adrian/code/phpApi/api/"
                }
            }
        }
    }
});
