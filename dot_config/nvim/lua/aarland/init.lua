require("aarland.set")
require("aarland.remap")
require("aarland.lazy_init")
require("aarland.none_ls_init")
require("aarland.config.lsp")
require("luasnip.loaders.from_vscode").lazy_load()


ColorMyPencils("tokyonight")
--require("aarland.make_files")

local augroup = vim.api.nvim_create_augroup
local aarland_group = augroup('aarland', {})
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})
autocmd({ "BufWritePre" }, {
    group = aarland_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({ 'BufWritePre' }, {
    group = aarland_group,
    pattern = '*',
    callback = function()
        vim.lsp.buf.format()
    end
}
)

autocmd('LspAttach', {
    group = aarland_group,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = { border = 'rounded' } }) end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = { border = 'rounded' } }) end,
            opts)
        vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
    end
})
