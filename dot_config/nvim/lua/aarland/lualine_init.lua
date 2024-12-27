local branch_max_width = 40
local branch_min_width = 10
local config = {
    options = {
        theme = "tokyonight",
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            "mode",
            {
                "branch",
                fmt = function(output)
                    local win_width = vim.o.columns
                    local max = branch_max_width
                    if win_width * 0.25 < max then
                        max = math.floor(win_width * 0.25)
                    end
                    if max < branch_min_width then
                        max = branch_min_width
                    end
                    if max % 2 ~= 0 then
                        max = max + 1
                    end
                    if output:len() >= max then
                        return output:sub(1, (max / 2) - 1)
                            .. "..."
                            .. output:sub(-1 * ((max / 2) - 1), -1)
                    end
                    return output
                end,
            },
        },
        lualine_b = {
            {
                "filename",
                file_status = false,
                path = 1,
            },
            {
                "diagnostics",
                update_in_insert = true,
            },
        },
        lualine_c = {},
        lualine_x = {
            "import",
        },
        -- Combine x and y
        lualine_y = {
            {
                function()
                    local lsps = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
                    local icon = require("nvim-web-devicons").get_icon_by_filetype(
                        vim.api.nvim_get_option_value('filetype', {})
                    )
                    if lsps and #lsps > 0 then
                        local names = {}
                        for _, lsp in ipairs(lsps) do
                            table.insert(names, lsp.name)
                        end
                        return string.format("%s %s", table.concat(names, ", "), icon)
                    else
                        return icon or ""
                    end
                end,
                on_click = function()
                    vim.api.nvim_command("LspInfo")
                end,
                color = function()
                    local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
                        vim.api.nvim_get_option_value("filetype", {})
                    )
                    return { fg = color }
                end,
            },
            "encoding",
            "progress",
        },
        lualine_z = {
            "location",
            {
                function()
                    local starts = vim.fn.line("v")
                    local ends = vim.fn.line(".")
                    local count = starts <= ends and ends - starts + 1 or starts - ends + 1
                    return count .. "V"
                end,
                cond = function()
                    return vim.fn.mode():find("[Vv]") ~= nil
                end,
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                "filetype",
                icon_only = true,
            },
            {
                "filename",
                path = 1,
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}

require('lualine').setup(config)
