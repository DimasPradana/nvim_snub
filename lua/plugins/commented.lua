-- vim.cmd([[ packadd commented ]])

require("commented").setup({
	codetags_keybindings = {
		fixme = "<leader>cf",
		fixme_line = "<leader>cfl",
		todo = "<leader>ct",
		todo_line = "<leader>ctl",
		bug = "<leader>cb",
		bug_line = "<leader>cbl",
		note = "<leader>cn",
		note_line = "<leader>cnl",
		wont_fix = "<leader>cwn",
		wont_fix_line = "<leader>cwfl",
	},
	hooks = {
		before_comment = require("ts_context_commentstring.internal").update_commentstring,
	},
	opts = {
		comment_padding = "  ", -- padding between starting and ending comment symbols
		keybindings = { n = "<leader>c", v = "<leader>c", nl = "<leader>cc" }, -- what key to toggle comment, nl is for mapping <leader>c$, just like dd for d
		prefer_block_comment = false, -- set it to true to automatically use block comment when multiple lines are selected
		set_keybindings = true, -- wheter or not keybindings is set on setup
		ex_mode_cmd = "Comment", -- command for commenting in ex-mode, set it null to not set the comment initially
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
