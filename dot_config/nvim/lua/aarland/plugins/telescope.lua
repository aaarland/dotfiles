return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        local multigrep = require("aarland.telescope.multigrep");
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', multigrep, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>frr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>fds', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>pb', function()
            builtin.buffers { attach_mappings = function(_, map)
                map({ "i", "n" }, "<M-d>", require("telescope.actions").delete_buffer)
                return true
            end }
        end, {})
        vim.keymap.set('n', '<leader>fo', builtin.treesitter, {})
    end
}
