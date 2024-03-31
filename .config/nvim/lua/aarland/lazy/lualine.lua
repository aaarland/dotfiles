return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local options = { theme = 'powerline' }
        local sections = { lualine_c = { { 'filename', path = 1 } } }
        return {
            options,
            sections
        }
    end
}
