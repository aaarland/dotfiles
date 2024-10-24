return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true, -- if you want to enable the plugin
        message_template = " <author> • <date> • <summary> • <<sha>>",
        date_format = "%r",
        virtual_text_column = 1,
    }
}
