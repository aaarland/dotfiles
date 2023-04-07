require("aarland.set")
require("aarland.remap")
require("aarland.packer")
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
autocmd({"BufWritePre"}, {
    group = aarland_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})


