require("aarland.set")
require("aarland.remap")
require("aarland.lazy_init")
require("aarland.none_ls_init")
require("luasnip.loaders.from_vscode").lazy_load()


ColorMyPencils("tokyonight")
require("aarland.lualine_init")
local goToSource = require("aarland.go_to_source_definition")
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

autocmd({ 'BufWritePre'}, {
    group = aarland_group,
    pattern = '*',
    callback = function(e)
        vim.lsp.buf.format()
    end
}
)

autocmd('LspAttach', {
    group = aarland_group,
    callback = function(e)
        local opts = { buffer = e.buf }


        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() goToSource(vim.fn.winnr() - 1, { fallback = false }) end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({border = 'rounded'}) end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
    end
})
