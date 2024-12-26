return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        local options = { theme = 'tokyonight' }
        local sections = { lualine_c = { { 'filename', path = 1 } } }
        return {
            options,
            sections
        }
    end
}
