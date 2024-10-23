return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local aarland_Fugitive = vim.api.nvim_create_augroup("aarland_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = aarland_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git('pull --rebase')
                end, opts)

            end,
        })


        vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>")
        vim.keymap.set("n", "<leader>gh", function()
            vim.cmd.diffget({ '//2' })
        end)
        vim.keymap.set("n", "<leader>gl", function()
            vim.cmd.diffget({ '//3' })
        end)
    end
}
