vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].buftype ~= "" then return end
    pcall(vim.treesitter.start, buf)
  end,
})
