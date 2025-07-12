local neotest = require("neotest")

if vim.bo.filetype ~= "java" then
    neotest.setup({
        adapters = {
            -- require("neotest-java")({
            -- 	junit_jar = nil,
            -- 	incremental_build = true,
            -- 	dap = { justMyCode = false },
            -- }),
        },
    })


    vim.keymap.set("n", "<leader>t", function()
        require("neotest").run.run()
    end, { desc = "Run nearest test" })

    vim.keymap.set("n", "<leader>T", function()
        require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run tests in current file" })

    vim.keymap.set("n", "<leader>tp", function()
        require("neotest").run.stop()
    end, { desc = "Stop running tests" })

    vim.keymap.set("n", "<leader>tq", function()
        require("neotest").output_panel.toggle()
    end, { desc = "Toggle output panel" })
end
