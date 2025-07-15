require("copilot").setup({
    suggestion = { enabled = false },
    filetypes = {},
    panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
            jump_prev = "p",
            jump_next = "n",
            accept = "<CR>",
            refresh = "r",
            -- open = "<leader>l",
        },
        layout = {
            position = "bottom", -- | top | left | right | horizontal | vertical
            ratio = 0.3
        },
    },
})

vim.keymap.set('n', '<leader>l', function() require("copilot.panel").toggle() end, { desc = "Open Copilot panel" })
