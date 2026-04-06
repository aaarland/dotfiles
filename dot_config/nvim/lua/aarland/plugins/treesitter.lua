return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install {
            "vimdoc", "javascript", "typescript", "c", "lua", "rust",
            "jsdoc", "bash",
        }
    end
}
