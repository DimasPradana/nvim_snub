vim.cmd([[ packadd bufferline ]])

vim.opt.termguicolors = true

require("bufferline").setup({
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = "both", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		-- indicator_icon = "▎",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
			-- remove extension from markdown files for example
			if buf.name:match("%.md") then
				return vim.fn.fnamemodify(buf.name, ":t:r")
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
		diagnostics_indicator = function(count)
			return "(" .. count .. ")"
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number, buf_numbers)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
				return true
			end
			-- filter out by buffer name
			if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
				return true
			end
			-- filter out based on arbitrary rules
			-- e.g. filter out vim wiki buffer from tabline in your work repo
			if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
				return true
			end
			-- filter out by it's index number in list (don't show first buffer)
			if buf_numbers[1] ~= buf_number then
				return true
			end
		end,
		offsets = { filetype = "NeoTree" }, -- {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
		color_icons = "true", -- true | false, -- whether or not to add the filetype icon highlights
		show_buffer_icons = "true", -- true | false, -- disable filetype icons for buffers
		show_buffer_close_icons = "true", -- true | false,
		show_buffer_default_icon = "true", -- true | false, -- whether or not an unrecognised filetype should show a default icon
		show_close_icon = "true", -- true | false,
		show_tab_indicators = "true", -- true | false,
		persist_buffer_sort = "true", -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = "false", -- false | true,
		always_show_bufferline = "true", -- true | false,
		sort_by = "insert_after_current", -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
		-- add custom logic
		-- 	return buffer_a.modified > buffer_b.modified
		-- end,
	},
	--[[ groups = {
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
	}, ]]
	-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
	highlights = {
		fill = {
			-- fg = "#000000",
			-- bg = "#212436",
			bg = "#24283b",
		},
		background = {
			-- fg = '<colour-value-here>',
			bg = "#24283b",
		},
		tab = {
			-- fg = '<colour-value-here>',
			bg = "#24283b",
		},
		--            tab_selected = {
		--                fg = tabline_sel_bg,
		--                bg = '<colour-value-here>'
		--            },
		--            tab_close = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            close_button = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            close_button_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            close_button_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		buffer_visible = {
			-- fg = "<colour-value-here>",
			bg = "#24283b",
		},
		--            buffer_selected = {
		--                fg = normal_fg,
		--                bg = '<colour-value-here>',
		--                bold = true,
		--                italic = true,
		--            },
		numbers = {
			-- fg = '<colour-value-here>',
			bg = "#24283b",
		},
		--            numbers_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--            },
		--            numbers_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                bold = true,
		--                italic = true,
		--            },
		--            diagnostic = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--            },
		--            diagnostic_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--            },
		--            diagnostic_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                bold = true,
		--                italic = true,
		--            },
		--            hint = {
		--                fg = '<colour-value-here>',
		--                sp = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            hint_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            hint_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            hint_diagnostic = {
		--                fg = '<colour-value-here>',
		--                sp = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            hint_diagnostic_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            hint_diagnostic_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            info = {
		--                fg = '<colour-value-here>',
		--                sp = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            info_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            info_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            info_diagnostic = {
		--                fg = '<colour-value-here>',
		--                sp = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            info_diagnostic_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            info_diagnostic_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            warning = {
		--                fg = '<colour-value-here>',
		--                sp = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            warning_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            warning_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            warning_diagnostic = {
		--                fg = '<colour-value-here>',
		--                sp = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            warning_diagnostic_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            warning_diagnostic_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = warning_diagnostic_fg
		--                bold = true,
		--                italic = true,
		--            },
		--            error = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--            },
		--            error_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            error_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            error_diagnostic = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--            },
		--            error_diagnostic_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            error_diagnostic_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                sp = '<colour-value-here>'
		--                bold = true,
		--                italic = true,
		--            },
		--            modified = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            modified_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            modified_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            duplicate_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--                italic = true,
		--            },
		--            duplicate_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--                italic = true
		--            },
		--            duplicate = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--                italic = true
		--            },
		separator_selected = {
			-- fg = '<colour-value-here>',
			-- bg = '<colour-value-here>'
			bg = "#24283b",
		},
		separator_visible = {
			-- fg = '<colour-value-here>',
			-- bg = '<colour-value-here>'
			bg = "#24283b",
		},
		separator = {
			-- fg = '<colour-value-here>',
			-- bg = '<colour-value-here>'
			bg = "#24283b",
		},
		--            indicator_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>'
		--            },
		--            pick_selected = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                bold = true,
		--                italic = true,
		--            },
		--            pick_visible = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                bold = true,
		--                italic = true,
		--            },
		--            pick = {
		--                fg = '<colour-value-here>',
		--                bg = '<colour-value-here>',
		--                bold = true,
		--                italic = true,
		--            },
		-- offset_separator = {
		-- 	fg = win_separator_fg,
		-- 	bg = separator_background_color,
		-- },
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
