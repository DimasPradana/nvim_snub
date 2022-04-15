vim.cmd([[ packadd bufferline ]])

vim.opt.termguicolors = true

require("bufferline").setup({
	options = {
		-- mode = "tabs",
		numbers = "both", -- none, ordinal, both, buffer_id
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		show_buffer_icons = true,
		buffer_close_icon = "",
		modified_icon = "",
		-- close_icon = "%@NvChad_bufferline_quitvim@%X",
		close_icon = "",
		show_close_icon = true,
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		show_tab_indicators = true,
		enforce_regular_tabs = false,
		view = "multiwindow",
		show_buffer_close_icons = true,
		-- separator_style = "thin",
		separator_style = "padded_slant",
		always_show_bufferline = true,
		diagnostics = false, -- "or nvim_lsp"
		custom_filter = function(buf_number)
			-- Func to filter out our managed/persistent split terms
			local present_type, type = pcall(function()
				return vim.api.nvim_buf_get_var(buf_number, "term_type")
			end)

			if present_type then
				if type == "vert" then
					return false
				elseif type == "hori" then
					return false
				else
					return true
				end
			else
				return true
			end
		end,
	},
	groups = {
		options = {
			toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
		},
		items = {
			{
				name = "Tests", -- Mandatory
				highlight = { gui = "underline", guisp = "blue" }, -- Optional
				priority = 2, -- determines where it will appear relative to other groups (Optional)
				icon = "", -- Optional
				matcher = function(buf) -- Mandatory
					return buf.filename:match("%_test") or buf.filename:match("%_spec")
				end,
			},
			{
				name = "Docs",
				highlight = { gui = "undercurl", guisp = "green" },
				auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
				matcher = function(buf)
					return buf.filename:match("%.md") or buf.filename:match("%.txt")
				end,
				separator = { -- Optional
					style = require("bufferline.groups").separator.tab,
				},
			},
		},
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
