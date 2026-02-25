local neoconf = require("neoconf");

local options = {}
if neoconf.get('vue') then
    options.init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location =
                "/home/adrian/.local/share/fnm/node-versions/v20.19.0/installation/lib/node_modules/@vue/typescript-plugin/",
                languages = { "javascript", "typescript", "vue" },
            },
        },
        filetypes = { "typescript", "javascript", "vue", "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx" },
    }
end
return options
