local on_attach = function(_, buffer)
    local bufopts = { noremap = true, silent = true, buffer = buffer }

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", bufopts)
    vim.keymap.set("n", "gt", "<Cmd>lua require('jdtls.tests').goto_subjects()<CR>", bufopts)

    vim.keymap.set('n', '<leader>o', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
    vim.keymap.set('n', '<leader>jv', "<Cmd>lua require('jdtls').extract_variable()<CR>",
        { desc = 'Extract Variable' })
    vim.keymap.set('v', '<leader>jv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
        { desc = 'Extract Variable' })
    vim.keymap.set('n', '<leader>jc', "<Cmd>lua require('jdtls').extract_constant()<CR>",
        { desc = 'Extract Constant' })
    vim.keymap.set('v', '<leader>jc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
        { desc = 'Extract Constant' })
    vim.keymap.set('v', '<leader>jm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
        { desc = 'Extract Method' })

    vim.keymap.set('n', '<leader>T', "<Cmd>lua require('jdtls').test_class()<CR>",
        { desc = 'Run Test Class' })
    vim.keymap.set('n', '<leader>t', "<Cmd>lua require('jdtls').test_nearest_method()<CR>",
        { desc = 'Run Nearest Test Method' })
    vim.keymap.set('n', '<leader>tq', "<Cmd>lua require('dap').repl.open()<CR>",
        { desc = 'Open test output' })

    vim.api.nvim_buf_create_user_command(0, "GenTest", function()
        require("jdtls.tests").generate()
    end, { desc = "Generate Tests" })

    vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ buffer = buffer })
    end, { buffer = buffer, desc = "Format current buffer with LSP" })
end

local status, jdtls = pcall(require, 'jdtls')
if not status then
    return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local bundles = {
    vim.fn.glob(
        "~/.nix-profile/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar",
        1)
}
vim.list_extend(bundles,
    vim.split(vim.fn.glob("~/.nix-profile/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar", 1),
        "\n"))

local config = {
    cmd = { 'jdtls' },
    on_attach = on_attach,
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1]),
    init_options = {
        bundles = bundles,
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            extendedClientCapabilities = extendedClientCapabilities,
            maven = {
                downloadSources = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = 'all',
                },
            },
            format = {
                enabled = true,
                settings = { url = "./eclipse-java-google-style.xml" }
            },
        }
    },
}
require('jdtls').start_or_attach(config)
