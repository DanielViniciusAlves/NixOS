require('trouble').setup({
    opts = {},
    cmd = "Trouble",
    keys = {
        N = "prev",
        n = "next",
        ["<cr>"] = "jump_close",
        h = "help",
    },
})

vim.keymap.set("n", "<leader>dT", "<CMD>Trouble diagnostics toggle focus=true<CR>")
vim.keymap.set("n", "<leader>dt", "<CMD>Trouble diagnostics toggle filter.buf=0 focus=true<CR>")
vim.keymap.set("n", "<leader>ds", "<CMD>Trouble symbols toggle focus=true<CR>")
