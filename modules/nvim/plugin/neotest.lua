local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-java")({
			junit_jar = nil,
			incremental_build = true,
			dap = { justMyCode = false },
		}),
	},
})

