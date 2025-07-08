local popup = require("plenary.popup")
local Win_id

local general_opts = {
    ["Elixir"] = "mix test --cover",
}
local opts = {
    ["exs"] = "mix test --warnings-as-errors",
}

function CloseMenu()
    vim.api.nvim_win_close(Win_id, true)
end

function ShowMenu(opts, cb)
    local height = #opts + 10
    local width = 20
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    Win_id = popup.create(opts, {
        title = "Available Test Commands",
        highlight = "MyPopupWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = cb,
    })
    local bufnr = vim.api.nvim_win_get_buf(Win_id)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
end

local function generate_command(extension, option)
    local command = option[extension]

    if command then
        return command
    else
        print("Unknown file extension: " .. extension .. "!")
        return false
    end
end

local function config_terminal_keymap()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>q<CR>', { noremap = true, silent = true })
end

function Test()
    local current_file = vim.fn.expand("%:p")
    local extension = vim.fn.expand("%:e")

    local test_command = generate_command(extension, opts)

    if test_command then
        vim.cmd('vnew | terminal echo ' .. current_file .. '; ' .. test_command .. ' ' .. current_file)

        local terminal_buffer = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_call(terminal_buffer, config_terminal_keymap)
    end
end

function TestProject()
    local options = {}
    for keys, _ in pairs(general_opts) do
        table.insert(options, keys)
    end

    local cb = function(_, sel)
        local test_command = generate_command(sel, general_opts)
        vim.cmd('vnew | terminal pwd;' .. test_command)

        local terminal_buffer = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_call(terminal_buffer, config_terminal_keymap)
    end
    ShowMenu(options, cb)
end

vim.api.nvim_command(":command! Test lua Test()")
vim.api.nvim_command(":command! TestProject lua TestProject()")

-- vim.keymap.set("n", "<leader>t", vim.cmd.Test)
-- vim.keymap.set("n", "<leader>T", vim.cmd.TestProject)
