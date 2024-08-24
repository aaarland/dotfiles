local function get_client(bufnr)
    for ____, client in pairs(vim.lsp.get_active_clients({bufnr = bufnr})) do
        if client.name == "tsserver" then
            return client
        end
    end
end
local function resolve_handler (bufnr, method)
    local client = get_client(bufnr)
    if not client then
        return
    end
    return client.handlers[method] or vim.lsp.handlers[method]
end
local function execute_command (bufnr, params, callback)
    local client = get_client(bufnr)
    if not client then
        return false
    end
    return client.request("workspace/executeCommand", params, callback)
end

local function go_to_source_definition(winnr, ____bindingPattern0)
    local fallback
    fallback = ____bindingPattern0.fallback
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local client = get_client(bufnr)
    if not client then
        return false
    end
    local positionParams = vim.lsp.util.make_position_params(winnr, client.offset_encoding)
    local requestOk = execute_command(
        bufnr,
        { command = "_typescript.goToSourceDefinition", arguments = { positionParams.textDocument.uri, positionParams.position } },
        function(...)
            local args = { ... }
            local handler = resolve_handler(bufnr, "textDocument/definition")
            if not handler then
                print("failed to go to source definition: could not resolve definition handler")
                return
            end
            local res = args[2] or ({})
            if vim.tbl_isempty(res) then
                if fallback == true then
                    return client.request("textDocument/definition", positionParams, handler, bufnr)
                end
                print("failed to go to source definition: no source definitions found")
                return
            end
            handler(unpack(args))
        end
    )
    if not requestOk then
        print("failed to go to source definition: tsserver request failed")
    end
    return requestOk
end
return go_to_source_definition
