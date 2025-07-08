local on_attach = function(client, buffer)
    local bufopts = { noremap = true, silent = true, buffer = buffer }

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", bufopts)
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", bufopts)

    local format = function()
        vim.lsp.buf.format({ bufnr = buffer })
    end

    if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<leader>f", format, bufopts)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()

require("lspconfig")["lua_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim", "it", "describe", "before_each", "after_each" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
})

require("lspconfig")["nil_ls"].setup({
    on_attach = on_attach,
    settings = {
        ["nil"] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
    capabilities = capabilities,
})
