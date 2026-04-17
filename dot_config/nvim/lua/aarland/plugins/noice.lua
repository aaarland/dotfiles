local function open_with_position(uri)
  pcall(vim.api.nvim_win_close, 0, true)

  local decoded = vim.uri_decode(uri)

  local file, fragment = decoded:match("file://([^#]+)#?(.*)")
  file = vim.uri_to_fname("file://" .. file)


  vim.cmd("edit " .. file)

  if fragment then
    local line, col = fragment:match("L(%d+),?(%d*)")
    if line then
      vim.api.nvim_win_set_cursor(0, {
        tonumber(line),
        tonumber(col ~= "" and col or 0)
      })
    end
  end
end
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
        local noiceOpen = require("noice.util")
        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },

            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
            markdown = {
                hover = {
                    ["%[.-%]%((%S-)%)"] = function(uri)
                        if uri:match("^file://") then
                                open_with_position(uri)
                            return
                        end
                        return noiceOpen(uri)
                    end
                }
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = "50%",
                        col = "50%",
                    }
                }
            }
        })
    end,
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:

        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
}
