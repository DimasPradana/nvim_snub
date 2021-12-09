vim.cmd([[ packadd which-key ]])

local wk = require("which-key")
-- Which Key Configuration
wk.setup({
	window = { border = "single" },
	layout = {
		spacing = 12,
		winblend = 0.5,
	},
})
