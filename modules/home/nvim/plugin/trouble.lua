require('trouble').setup({
    opts = {},
    cmd = "Trouble",
    keys = {
        N = "prev",
        n = "next",
        ["<cr>"] = "jump_close",
        h = "help",
        {
            "<leader>dT",
            "<cmd>Trouble diagnostics toggle focus=true<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>dt",
            "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>ds",
            "<cmd>Trouble symbols toggle focus=true<cr>",
            desc = "Symbols (Trouble)",
        },
    },
})
