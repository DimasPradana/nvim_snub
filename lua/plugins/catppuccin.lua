vim.cmd([[ packadd catppuccin ]])
local catppuccin = require("catppuccin")
--[[ local cp_api = require("catppuccin.api.colors")
local colors = cp_api.get_colors() ]]
local colors = require("catppuccin.api.colors").get_colors()

catppuccin.setup({
	transparent_background = true,
	term_colors = true,
	styles = {
		comments = "italic",
		functions = "italic",
		keywords = "italic",
		strings = "NONE",
		variables = "italic",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic",
			},
			underlines = {
				errors = "underline",
				hints = "underline",
				warnings = "underline",
				information = "underline",
			},
		},
		lsp_trouble = false,
		cmp = true,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = false,
			show_root = false,
			transparent_panel = false,
		},
		neotree = {
			enabled = true,
			show_root = true,
			transparent_panel = true,
		},
		which_key = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = false,
		hop = true,
		notify = true,
		telekasten = true,
		symbols_outline = true,
	},
	catppuccin.remap({
		-- Comment = { fg = colors.flamingo, bg = colors.red },
		-- hi_group = { fg = colors.white, bg = colors.blue },
	}),
})

--[[ catppuccin.before_loading = function()
	print("I ran before loading Catppuccin!")
end

catppuccin.after_loading = function()
	print("I ran after loading Catppuccin!")
end ]]

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
