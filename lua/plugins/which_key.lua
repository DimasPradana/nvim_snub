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

-- {{{ lua and lsp
wk.register({
	["<leader>"] = {
		l = {
			name = "Lua and LSP",
			u = { "<CMD>echo '｡:.ﾟヽ(*´∀`)ﾉﾟ.:｡' | luafile %<CR>", "source lua" },
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
			c = { "<CMD>lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>", "print LSP" },
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
			r = { "<CMD>!go run main.go<CR>", "go run" }, -- go run main
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
			e = { "<CMD>NeoTreeFocusToggle<CR>", "Toggle" },
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
			name = "Packer",
			s = { "<CMD>PackerSync<CR>", "Packer Sync" },
			c = { "<CMD>PackerCompile<CR>", "Packer Compile" },
			i = { "<CMD>PackerInstall<CR>", "Packer Install" },
			l = { "<CMD>PackerClean<CR>", "Packer Clean" },
		},
	},
}) -- }}}

--{{{ refresh brave
wk.register({
	["<leader>"] = {
		r = {
			"<CMD>!xdotool search --onlyvisible --class Brave windowfocus key F5 && xdotool search --onlyvisible --class Kitty windowfocus<CR>",
			"Refresh Brave and back to kitty",
		},
	},
}) --}}}

--{{{ Distant
-- wk.register({
-- 	["<leader>"] = {
-- 		d = {
--       name = "Distant",
--       d = { "<CMD>DistantLaunch <CR>", "GIS" },
-- 		},
-- 	},
-- }) --}}}

--{{{ toggle indent blank line
wk.register({
	["<leader>"] = {
		i = { "<CMD>IndentBlanklineToggle<CR>", "Toggle IndentBlankline" }, -- Toggle indent blank line
	},
}) --}}}

--{{{ toggle list char
wk.register({
	["<leader>"] = {
		w = {
			name = "list",
			e = { "<CMD>set list<CR>", "Set List" },
			d = { "<CMD>set nolist<CR>", "Set No List" },
			l = { "<CMD>set listchars<CR>", "show listchars" },
		},
	},
}) --}}}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
