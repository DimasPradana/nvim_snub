vim.cmd([[ packadd indent-blankline.nvim ]])

vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

vim.opt.list = false -- untuk hilangkan unicode spasi, tab, newline, dll
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	-- indentLine_enabled = true,
	-- indentLine_enabled = false,
	enabled = false,
	-- char = "▏",'│', '┊','¦'
	char = "¦",
	filetype_exclude = {
		"help",
		"terminal",
		"dashboard",
		"packer",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"NvimTree",
		"Neotree",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
	show_end_of_line = true,
	use_treesitter = true,
	context_patterns = {
		"class",
		"^func",
		"method",
		"^if",
		"while",
		"for",
		"with",
		"try",
		"except",
		"arguments",
		"argument_list",
		"object",
		"dictionary",
		"element",
		"table",
		"tuple",
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
