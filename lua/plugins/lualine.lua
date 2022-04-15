vim.cmd([[ packadd lualine ]])

-- {{{ tambahan
local custom_fname = require("lualine.components.filename"):extend()
local highlight = require("lualine.highlight")
local default_status_colors = { saved = "#228B22", modified = "#C70039" }

function custom_fname:init(options)
	custom_fname.super.init(self, options)
	self.status_colors = {
		saved = highlight.create_component_highlight_group(
			{ bg = default_status_colors.saved },
			"filename_status_saved",
			self.options
		),
		modified = highlight.create_component_highlight_group(
			{ bg = default_status_colors.modified },
			"filename_status_modified",
			self.options
		),
	}
	if self.options.color == nil then
		self.options.color = ""
	end
end

function custom_fname:update_status()
	local data = custom_fname.super.update_status(self)
	data = highlight.component_format_highlight(
		vim.bo.modified and self.status_colors.modified or self.status_colors.saved
	) .. data
	return data
end

--[[ local function window()
	return vim.api.nvim_get_current_buf()
end

local function keymap()
	if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
		return "⌨ " .. vim.b.keymap_name
	end
	return ""
end ]]

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide_width and win_width < hide_width then
			return ""
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
		end
		return str
	end
end
-- }}}

-- -- {{{ evil
-- -- Eviline config for lualine
-- -- Author: shadmansaleh
-- -- Credit: glepnir
-- local lualine = require("lualine")
--
-- -- Color table for highlights
-- -- stylua: ignore
-- local colors = {
--   bg       = '#202328',
--   fg       = '#bbc2cf',
--   yellow   = '#ECBE7B',
--   cyan     = '#008080',
--   darkblue = '#081633',
--   green    = '#98be65',
--   orange   = '#FF8800',
--   violet   = '#a9a1e1',
--   magenta  = '#c678dd',
--   blue     = '#51afef',
--   red      = '#ec5f67',
-- }
--
-- local conditions = {
-- 	buffer_not_empty = function()
-- 		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
-- 	end,
-- 	hide_in_width = function()
-- 		return vim.fn.winwidth(0) > 80
-- 	end,
-- 	check_git_workspace = function()
-- 		local filepath = vim.fn.expand("%:p:h")
-- 		local gitdir = vim.fn.finddir(".git", filepath .. ";")
-- 		return gitdir and #gitdir > 0 and #gitdir < #filepath
-- 	end,
-- }
--
-- -- Config
-- local config = {
-- 	options = {
-- 		-- Disable sections and component separators
-- 		component_separators = "",
-- 		section_separators = "",
-- 		theme = {
-- 			-- We are going to use lualine_c an lualine_x as left and
-- 			-- right section. Both are highlighted by c theme .  So we
-- 			-- are just setting default looks o statusline
-- 			normal = { c = { fg = colors.fg, bg = colors.bg } },
-- 			inactive = { c = { fg = colors.fg, bg = colors.bg } },
-- 		},
-- 	},
-- 	sections = {
-- 		-- these are to remove the defaults
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 		-- These will be filled later
-- 		lualine_c = {},
-- 		lualine_x = {},
-- 	},
-- 	inactive_sections = {
-- 		-- these are to remove the defaults
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 		lualine_c = {},
-- 		lualine_x = {},
-- 	},
-- }
--
-- -- Inserts a component in lualine_c at left section
-- local function ins_left(component)
-- 	table.insert(config.sections.lualine_c, component)
-- end
--
-- -- Inserts a component in lualine_x ot right section
-- local function ins_right(component)
-- 	table.insert(config.sections.lualine_x, component)
-- end
--
-- ins_left({
-- 	function()
-- 		return "▊"
-- 	end,
-- 	color = { fg = colors.blue }, -- Sets highlighting of component
-- 	padding = { left = 0, right = 1 }, -- We don't need space before this
-- })
--
-- ins_left({
-- 	-- mode component
-- 	function()
-- 		-- auto change color according to neovims mode
-- 		local mode_color = {
-- 			n = colors.red,
-- 			i = colors.green,
-- 			v = colors.blue,
-- 			[""] = colors.blue,
-- 			V = colors.blue,
-- 			c = colors.magenta,
-- 			no = colors.red,
-- 			s = colors.orange,
-- 			S = colors.orange,
-- 			[""] = colors.orange,
-- 			ic = colors.yellow,
-- 			R = colors.violet,
-- 			Rv = colors.violet,
-- 			cv = colors.red,
-- 			ce = colors.red,
-- 			r = colors.cyan,
-- 			rm = colors.cyan,
-- 			["r?"] = colors.cyan,
-- 			["!"] = colors.red,
-- 			t = colors.red,
-- 		}
-- 		vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
-- 		return ""
-- 	end,
-- 	color = "LualineMode",
-- 	padding = { right = 1 },
-- })
--
-- ins_left({
-- 	-- filesize component
-- 	"filesize",
-- 	cond = conditions.buffer_not_empty,
-- })
--
-- ins_left({
-- 	"filename",
-- 	cond = conditions.buffer_not_empty,
-- 	color = { fg = colors.magenta, gui = "bold" },
-- })
--
-- ins_left({ "location" })
--
-- ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
--
-- ins_left({
-- 	"diagnostics",
-- 	sources = { "nvim_diagnostic" },
-- 	symbols = { error = " ", warn = " ", info = " " },
-- 	diagnostics_color = {
-- 		color_error = { fg = colors.red },
-- 		color_warn = { fg = colors.yellow },
-- 		color_info = { fg = colors.cyan },
-- 	},
-- })
--
-- -- Insert mid section. You can make any number of sections in neovim :)
-- -- for lualine it's any number greater then 2
-- ins_left({
-- 	function()
-- 		return "%="
-- 	end,
-- })
--
-- ins_left({
-- 	-- Lsp server name .
-- 	function()
-- 		local msg = "No Active Lsp"
-- 		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
-- 		local clients = vim.lsp.get_active_clients()
-- 		if next(clients) == nil then
-- 			return msg
-- 		end
-- 		for _, client in ipairs(clients) do
-- 			local filetypes = client.config.filetypes
-- 			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
-- 				return client.name
-- 			end
-- 		end
-- 		return msg
-- 	end,
-- 	icon = " LSP:",
-- 	color = { fg = "#ffffff", gui = "bold" },
-- })
--
-- -- Add components to right sections
-- ins_right({
-- 	"o:encoding", -- option component same as &encoding in viml
-- 	fmt = string.upper, -- I'm not sure why it's upper case either ;)
-- 	cond = conditions.hide_in_width,
-- 	color = { fg = colors.green, gui = "bold" },
-- })
--
-- ins_right({
-- 	"fileformat",
-- 	fmt = string.upper,
-- 	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
-- 	color = { fg = colors.green, gui = "bold" },
-- })
--
-- ins_right({
-- 	"branch",
-- 	icon = "",
-- 	color = { fg = colors.violet, gui = "bold" },
-- })
--
-- ins_right({
-- 	"diff",
-- 	-- Is it me or the symbol for modified us really weird
-- 	symbols = { added = " ", modified = "柳 ", removed = " " },
-- 	diff_color = {
-- 		added = { fg = colors.green },
-- 		modified = { fg = colors.orange },
-- 		removed = { fg = colors.red },
-- 	},
-- 	cond = conditions.hide_in_width,
-- })
--
-- ins_right({
-- 	function()
-- 		return "▊"
-- 	end,
-- 	color = { fg = colors.blue },
-- 	padding = { left = 1 },
-- })
--
-- -- Now don't forget to initialize lualine
-- lualine.setup(config)
-- -- }}}

-- -- {{{ Bubble
-- -- Bubbles config for lualine
-- -- Author: lokesh-krishna
-- -- MIT license, see LICENSE for more details.
--
-- -- stylua: ignore
-- local colors = {
--   blue   = '#80a0ff',
--   cyan   = '#79dac8',
--   black  = '#080808',
--   white  = '#c6c6c6',
--   red    = '#ff5189',
--   violet = '#d183e8',
--   grey   = '#303030',
-- }
--
-- local bubbles_theme = {
-- 	normal = {
-- 		a = { fg = colors.black, bg = colors.violet },
-- 		b = { fg = colors.white, bg = colors.grey },
-- 		c = { fg = colors.black, bg = colors.black },
-- 	},
--
-- 	insert = { a = { fg = colors.black, bg = colors.blue } },
-- 	visual = { a = { fg = colors.black, bg = colors.cyan } },
-- 	replace = { a = { fg = colors.black, bg = colors.red } },
--
-- 	inactive = {
-- 		a = { fg = colors.white, bg = colors.black },
-- 		b = { fg = colors.white, bg = colors.black },
-- 		c = { fg = colors.black, bg = colors.black },
-- 	},
-- }
--
-- require("lualine").setup({
-- 	options = {
-- 		theme = bubbles_theme,
-- 		component_separators = "|",
-- 		section_separators = { left = "", right = "" },
-- 	},
-- 	sections = {
-- 		lualine_a = {
-- 			{ "mode", separator = { left = "" }, right_padding = 2 },
-- 		},
-- 		lualine_b = { "filename", "branch" },
-- 		lualine_c = { "fileformat" },
-- 		lualine_x = {},
-- 		lualine_y = { "filetype", "progress" },
-- 		lualine_z = {
-- 			{ "location", separator = { right = "" }, left_padding = 2 },
-- 		},
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = { "filename" },
-- 		lualine_b = {},
-- 		lualine_c = {},
-- 		lualine_x = {},
-- 		lualine_y = {},
-- 		lualine_z = { "location" },
-- 	},
-- 	tabline = {},
-- 	extensions = {},
-- })
-- -- }}}

-- -- {{{ tokyonight
-- local lualine = require("lualine")
-- local config = {
-- 	options = {
-- 		theme = "tokyonight",
-- 	},
-- }
-- lualine.setup(config)
-- -- }}}

-- {{{ snub
local lualine = require("lualine")
lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		--[[ component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" }, ]]
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "|", right = "|" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			{
				"windows",
				show_filename_only = true, -- Shows shortened relative path when set to false.
				show_modified_status = true, -- Shows indicator when the window is modified.

				mode = 1, -- 0: Shows window name
				-- 1: Shows window index
				-- 2: Shows window name + window index

				max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
				-- it can also be a function that returns
				-- the value of `max_length` dynamically.
				filetype_names = {
					TelescopePrompt = "Telescope",
					dashboard = "Dashboard",
					packer = "Packer",
					fzf = "FZF",
					alpha = "Alpha",
				}, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )

				disabled_buftypes = { "quickfix", "prompt" }, -- Hide a window if its buffer's type is disabled

				windows_color = {
					-- Same values as the general color option can be used here.
					active = "lualine_{section}_normal", -- Color for active window.
					inactive = "lualine_{section}_inactive", -- Color for inactive window.
				},
				fmt = trunc(10, 2, nil, true), -- Format function, formats the component's output.
			},
			{
				"mode",
				icons_enabled = true, -- Enables the display of icons alongside the component.
				-- Defines the icon to be displayed in front of the component.
				-- Can be string|table
				-- As table it must contain the icon as first entry and can use
				-- color option to custom color the icon. Example:
				-- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}\}\}
				icon = nil,

				separator = nil, -- Determines what separator to use for the component.
				-- Note:
				--  When a string is provided it's treated as component_separator.
				--  When a table is provided it's treated as section_separator.
				--  Passing an empty string disables the separator.
				--
				-- These options can be used to set colored separators
				-- around a component.
				--
				-- The options need to be set as such:
				--   separator = { left = '', right = ''}
				--
				-- Where left will be placed on left side of component,
				-- and right will be placed on its right.
				--

				cond = nil, -- Condition function, the component is loaded when the function returns `true`.

				-- Defines a custom color for the component:
				--
				-- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
				-- Note:
				--  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
				-- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
				-- color functions can be used to have different colors based on state as shown below.
				--
				-- Examples:
				--   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
				--   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
				--   color = 'WarningMsg'   -- Highlight groups can also be used.
				--   color = function(section)
				--      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
				--   end,
				color = nil, -- The default is your theme's color for that section and mode.

				-- Specify what type a component is, if omitted, lualine will guess it for you.
				--
				-- Available types are:
				--   [format: type_name(example)], mod(branch/filename),
				--   stl(%f/%m), var(g:coc_status/bo:modifiable),
				--   lua_expr(lua expressions), vim_fun(viml function name)
				--
				-- Note:
				-- lua_expr is short for lua-expression and vim_fun is short for vim-function.
				type = nil,

				padding = 1, -- Adds padding to the left and right of components.
				-- Padding can be specified to left or right independently, e.g.:
				--   padding = { left = left_padding, right = right_padding }

				fmt = trunc(80, 4, nil, true), -- Format function, formats the component's output.
			},
		},
		lualine_b = {
			"branch",
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				diff_color = {
					-- Same color values as the general color option can be used here.
					added = "DiffAdd", -- Changes the diff's added color
					modified = "DiffChange", -- Changes the diff's modified color
					removed = "DiffDelete", -- Changes the diff's removed color you
				},
				symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
				source = diff_source, -- A function that works as a data source for diff.
				-- It must return a table as such:
				--   { added = add_count, modified = modified_count, removed = removed_count }
				-- or nil on failure. count <= 0 won't be displayed.
			},
			{
				"diagnostics",
				-- Table of diagnostic sources, available sources are:
				--   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
				-- or a function that returns a table as such:
				--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
				sources = { "nvim_diagnostic", "nvim_diagnostic" },

				-- Displays diagnostics for the defined severity types
				sections = { "error", "warn", "info", "hint" },

				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = "DiagnosticError", -- Changes diagnostics' error color.
					warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
					info = "DiagnosticInfo", -- Changes diagnostics' info color.
					hint = "DiagnosticHint", -- Changes diagnostics' hint color.
				},
				symbols = { error = "  ", warn = "  ", info = "  ", hint = "⚝  " }, -- error = " ", warn = " ", info = " "
				colored = true, -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false, -- Show diagnostics even if there are none.
			},
		},
		-- lualine_c = { "filename" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- display file status (readonly status, modified status)
				path = 1, -- 0 just a filename, 1 relative path, 2 absolute path
				shorting_target = 40, -- shortenpath to leave 40 spaces in the window for other components
			},
		},
		lualine_x = {
			-- "fileformat",
			{
				"filetype",
				colored = true, -- display filetype icon in color if set to true
				icon_only = false, -- display only an icon for filetype
				-- custom_fname,
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "quickfix", "toggleterm" },
})
-- }}}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
