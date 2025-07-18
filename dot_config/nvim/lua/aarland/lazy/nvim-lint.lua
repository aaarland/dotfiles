return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()

    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" }, -- if applicable

    }

    -- -- Define the linter manually
    -- lint.linters.eslint_d = {
    --   name = "eslint_d",
    --   cmd = vim.fn.exepath("eslint_d"), -- full path from Mason
    --   stdin = false,
    --   args = {
    --     "--format",
    --     "json",
    --     "--stdin-filename",
    --
    --     function()
    --       return vim.api.nvim_buf_get_name(0)
    --     end,
    --   },
    --   stream = "stdout",
    --   ignore_exitcode = true,
    --   parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
    --
    --     source = "eslint_d",
    --     severity = vim.diagnostic.severity.WARN,
    --   }),
    -- }


    -- Autocmd to trigger linting on save
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
