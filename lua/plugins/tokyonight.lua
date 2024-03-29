require("tokyonight").setup({
	-- -- use the night style
	-- style = "storm",
	-- -- disable italic for functions
	-- styles = {
	-- 	functions = {},
	-- },
	-- sidebars = { "qf", "vista_kind", "terminal", "packer" },
	-- -- Change the "hint" color to the "orange" color, and make the "error" color bright red
	-- on_colors = function(colors)
	-- 	colors.hint = colors.orange
	-- 	colors.error = "#ff0000"
	-- 	colors.bg_popup = colors.blue7
	-- end,
	-- make telescope borderless
	on_highlights = function(hl, c)
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = prompt,
		}
		hl.TelescopePromptBorder = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePromptTitle = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,
})
