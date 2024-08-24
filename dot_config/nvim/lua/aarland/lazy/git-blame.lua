return {
    "f-person/git-blame.nvim",
    config = function()
        vim.g.gitblame_message_template = '<author> • <date> • <summary>'
        vim.g.gitblame_date_format = "%r"
    end
}
