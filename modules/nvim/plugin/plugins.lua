-- Transparent

require("transparent").setup({
    extra_groups = {
        "NormalFloat",
    },
})

-- Oil

require("oil").setup()

-- Comment
require("Comment").setup({
    opleader = {
        line = '<leader>c',
        block = 'gb',
    },
})

-- Mark
require("marks").setup({
    mappings = {
        set_next = "m;",
        delete_line = "m'",
    },
})

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<leader>[", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>]", function() harpoon:list():next() end)
