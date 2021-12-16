-- vim.cmd([[ packadd commented ]])

require("gitsigns").setup({
	signs = {
		add = { hl = "SignAdd", text = "▎" },
		change = { hl = "SignChange", text = "▎" },
		delete = { hl = "SignDelete", text = "🭻" },
		topdelete = { hl = "SignDelete", text = "🭶" },
		changedelete = { hl = "SignChange", text = "▎" },
	},
	watch_gitdir = {
		interval = 1000,
	},
	current_line_blame = true,
	sign_priority = 5,
	update_debounce = 500,
	status_formatter = nil, -- Use default
	diff_opts = {
		internal = true,
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
