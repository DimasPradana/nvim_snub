vim.cmd([[ packadd which-key ]])

local wk = require("which-key")
-- local keymap = require "keymap"

-- colors
vim.api.nvim_set_hl(0, "WhichKey", { fg = "#db4b4b", bg = "NONE" })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "#9ece6a", bg = "NONE" })
vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = "#c0caf5", bg = "NONE" })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#7aa2f7", bg = "NONE" })
vim.api.nvim_set_hl(0, "WhichKeyFloat", { fg = "#ff9e64", bg = "NONE" })
vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = "#ff9e64", bg = "NONE" })
vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = "#7aa2f7", bg = "NONE" })

-- Which Key Configuration
wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = { "⚈", "─", "⚈", "│", "⚈", "─", "⚈", "│" }, -- none, single, double, shadow
		position = "top", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 40 }, -- min and max width of the columns
		spacing = 10, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})

-- {{{ lua and lsp
wk.register({
	["<leader>"] = {
		l = {
			name = "Lua and LSP",
			u = { "<CMD>echo '｡:.ﾟヽ(*´∀`)ﾉﾟ.:｡' | luafile %<CR>", "source lua" },
			-- u = { "<CMD>lua require('notify')('sourcing nvim pak', 'info') | luafile %<CR>", "sourcing nvim" },
			--[[ u = {
				function()
					require("notify")("sourcing nvim kang", "info")
					print("hello")
				end,
				"sourcing nvim",
			}, ]]
			r = { "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "lsp references" },
			s = {
				name = "lsp symbols",
				d = { "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>", "lsp doc symbols" },
				w = { "<CMD>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "lsp workspace symbols" },
				y = {
					"<CMD>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>",
					"lsp dynamic workspace symbols",
				},
			},
			c = { "<CMD>lua require('telescope.builtin').lsp_code_actions()<CR>", "lsp code actions" },
			d = {
				name = "lsp diagnostic",
				-- d = { "<CMD>Telescope diagnostics bufnr=0()<CR>", "lsp doc diag" },
				w = { "<CMD>Telescope diagnostics<CR>", "lsp work diag" },
			},
			i = { "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", "lsp implementation" },
			e = {
				name = "lsp definitions",
				e = { "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>", "lsp definitions" },
				t = { "<CMD>lua require('telescope.builtin').lsp_type_definitions()<CR>", "lsp type definitions" },
			},
			l = { "<CMD>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>", "print LSP" },
			k = { "<CMD>lua print(vim.inspect(vim.lsp.buf.hover()))<CR>", "hover" },
			R = { "<CMD>lua print(vim.inspect(vim.lsp.buf.rename()))<CR>", "rename" },
		},
	},
}) -- }}}

-- {{{ yank and paste
wk.register({
	["<leader>"] = {
		y = {
			name = "Yank & Paste",
			y = { '"+y', "yank" },
			p = { '"+p', "paste" },
			Y = { "y$", "yank line" },
		},
	},
}) -- }}}

-- {{{ telescope
wk.register({
	["<leader>"] = {
		f = {
			name = "Telescope",
			d = { "<CMD>TodoTelescope<CR>", "todo comments using telescope" },
			f = { "<CMD>lua require('telescope.builtin').find_files()<CR>", "find files" },
			g = { "<CMD>lua require('telescope.builtin').grep_string()<CR>", "grep string" },
			w = { "<CMD>lua require('telescope.builtin').live_grep()<CR>", "live grep" },
			b = { "<CMD>lua require('telescope.builtin').buffers()<CR>", "buffers" },
			c = { "<CMD>lua require('telescope.builtin').commands()<CR>", "commands" },
			k = { "<CMD>lua require('telescope.builtin').keymaps()<CR>", "keymaps" },
			r = { "<CMD>lua require('telescope.builtin').registers()<CR>", "register" },
			h = { "<CMD>lua require('telescope.builtin').highlights()<CR>", "highlight" },
			i = {
				name = "history",
				c = { "<CMD>lua require('telescope.builtin').command_history()<CR>", "command history" },
				h = { "<CMD>lua require('telescope.builtin').search_history()<CR>", "search history" },
			},
			m = {
				name = "mark and man pages",
				a = { "<CMD>lua require('telescope.builtin').marks()<CR>", "marks" },
				m = { "<CMD>lua require('telescope.builtin').man_pages()<CR>", "man pages" },
			},
			t = { "<CMD>lua require('telescope.builtin').treesitter()<CR>", "telescope > treesitter" }, -- Lists Function names, variables, from Treesitter!
			e = {
				"<CMD>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji', 'gitmoji'} }<CR>",
				"telescope emoji",
			}, -- emoji dong 😀
		},
	},
}) -- }}}

-- {{{ hop
wk.register({
	["<leader>"] = {
		h = {
			name = "Hop",
			w = { "<CMD>lua require('hop').hint_words()<CR>", "hint words" },
			p = { "<CMD>lua require('hop').hint_patterns()<CR>", "hint patterns" },
			l = { "<CMD>lua require('hop').hint_lines()<CR>", "hint lines" },
			c = { "<CMD>lua require('hop').hint_char2()<CR>", "hint chars" },
			s = { "<CMD>HopLineStart<CR>", "Line Start" },
		},
		ha = {
			name = "Hop Anywhere",
			w = { "<CMD>HopAnywhere<CR>", "Any Where" },
			l = { "<CMD>HopAnywhereCurrentLine<CR>", "Current Line" },
		},
		hm = {
			name = "Harpoon",
			a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "add mark harpoon" },
			t = { "<CMD>Telescope harpoon marks<CR>", "show harpoon on telescope" },
		},
	},
}) -- }}}

-- {{{ node
wk.register({
	["<leader>"] = {
		o = {
			name = "Node",
			i = { "<CMD>lua require('node').npm_install()<CR>", "npm install" },
			r = { "<CMD>!tmux split-window 'npm run dev'; read;<CR>", "npm run dev" }, -- svelte run develepment
			b = { "<CMD>!node build/index.js<CR>", "npm build" }, -- npm build / svelte build
		},
	},
}) -- }}}

-- {{{ golang and glow
wk.register({
	["<leader>"] = {
		g = {
			name = "go and glow",
			r = { "<CMD>!go run ./main.go<CR>", "go run" }, -- go run main
			--  BUG: snub on Mon 05 Dec 2022 09:53:53 : belum selesai untuk buat function pakai feedkey seperti di keymaps --
			--[[ r = {
				function()
					-- samid(":vs term://fish <CR>", "n")
					-- samid("aecho 'hello'<CR>", "n")
					-- "<CMD>vs term://fish <CR>"
					vim.api.nvim_command("vs term://fish")
					print("hello")
				end,
				"run go lang",
			}, -- go run main ]]
			l = { "<CMD>Glow<CR>", "markdown previewer" },
		},
	},
}) -- }}}

-- {{{ nvimtree
wk.register({
	["<leader>"] = {
		e = {
			-- name = "Nvimtree",
			name = "NeoTree",
			-- e = { "<CMD>NvimTreeToggle<CR>", "Toggle" },
			-- r = { "<CMD>NvimTreeRefresh<CR>", "Refresh" },
			-- w = { "<CMD>NvimTreeFocus<CR>", "Focus" },
			-- e = { "<CMD>NeoTreeFocusToggle<CR>", "Toggle" },
			e = { "<CMD>Neotree action=focus source=filesystem position=left toggle=true<CR>", "Toggle filesystem" },
			b = { "<CMD>Neotree action=focus source=buffers position=right toggle=true<CR>", "Toggle buffer" },
			g = { "<CMD>Neotree action=focus source=git_status position=right toggle=true<CR>", "Toggle git" },
			-- r = { "<CMD>NvimTreeRefresh<CR>", "Refresh" },
			-- w = { "<CMD>NvimTreeFocus<CR>", "Focus" },
		},
	},
}) -- }}}

-- {{{ formatter
wk.register({
	--[[ ["<leader>"] = {
		n = { "<CMD>Neoformat<CR>", "Neoformat" }, -- run neoformat
	}, ]]
}) -- }}}

-- {{{ packer
wk.register({
	["<leader>"] = {
		p = {
			name = "Packer and yank",
			s = { "<CMD>PackerSync<CR>", "Packer Sync" },
			c = { "<CMD>PackerCompile<CR>", "Packer Compile" },
			i = { "<CMD>PackerInstall<CR>", "Packer Install" },
			l = { "<CMD>PackerClean<CR>", "Packer Clean" },
			p = { "<CMD>PackerProfile<CR>", "Packer Profile" },
			u = { "<CMD>PackerUpdate<CR>", "Packer Update" },
			y = { "<CMD>YankyRingHistory<CR>", "Yanky" },
		},
	},
}) -- }}}

-- {{{ refresh brave
wk.register({
	["<leader>"] = {
		r = {
			"<CMD>!xdotool search --onlyvisible --class Brave windowfocus key F5 && xdotool search --onlyvisible --class Kitty windowfocus<CR>",
			"Refresh Brave and back to kitty",
		},
	},
}) --}}}

-- {{{ Distant
-- wk.register({
-- 	["<leader>"] = {
-- 		d = {
--       name = "Distant",
--       d = { "<CMD>DistantLaunch <CR>", "GIS" },
-- 		},
-- 	},
-- }) --}}}

-- {{{ toggle indent blank line
wk.register({
	["<leader>"] = {
		i = { "<CMD>IndentBlanklineToggle<CR>", "Toggle IndentBlankline" }, -- Toggle indent blank line
	},
}) --}}}

-- {{{ toggle list char
wk.register({
	["<leader>"] = {
		w = {
			name = "list",
			e = { "<CMD>set list<CR>", "Set List" },
			d = { "<CMD>set nolist<CR>", "Set No List" },
			l = { "<CMD>set listchars<CR>", "show listchars" },
			v = { "<CMD>NvimContextVtToggle<CR>", "show virtual text" },
			w = { "<CMD>set wrap<CR>", "set wrap" },
			n = { "<CMD>set nowrap<CR>", "set nowrap" },
		},
	},
}) --}}}

-- {{{ delete buffer
wk.register({
	["<leader>"] = {
		b = {
			name = "buffer",
			d = { "<CMD>bd!<CR>", "Close Buffer" },
		},
	},
}) --}}}

-- {{{ symbols outline
wk.register({
	["<leader>"] = {
		a = {
			name = "symbols outline",
			s = { "<CMD>SymbolsOutline<CR>", "tagbar" },
		},
	},
}) --}}}

-- {{{ undotree
wk.register({
	["<leader>"] = {
		u = { "<CMD>lua require('undotree').toggle()<CR>", "undotree" },
	},
}) --}}}

-- {{{ chatgpt
wk.register({
	["<leader>"] = {
		ch = { "<CMD>:ChatGPT<CR>", "chatgpt" },
	},
}) --}}}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
