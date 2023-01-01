vim.cmd([[packadd packer.nvim]]) -- Load Packer

-- {{{ automatically packer compile on save / source this plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]) -- }}}

return require("packer").startup(function(use)
	-- {{{ Packer
	use({
		"wbthomason/packer.nvim",
		opt = true,
	}) -- }}}

	-- {{{ StartupTime
	--[[ use({
		"tweekmonster/startuptime.vim",
		event = "VimEnter",
	}) -- }}} ]]

	-- {{{ Filetype replacement
	--[[ use({
		"nathom/filetype.nvim",
	}) -- }}} ]]

	-- {{{ vim motion case sensitive
	use({
		"chaoren/vim-wordmotion",
		event = "BufRead",
	}) -- }}}

	-- {{{ Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		-- "~/repos/telescope.nvim",
		-- event = "VimEnter",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			-- "nvim-telescope/telescope-frecency.nvim",
			-- "nvim-telescope/telescope-media-files.nvim",
			-- "nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			-- "gbrlsnchs/telescope-lsp-handlers.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugins/telescope")
		end,
	}) -- }}}

	-- {{{ NvimTree
	--[[ use({
		"kyazdani42/nvim-tree.lua",
		event = "BufRead",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("plugins/nvim-tree")
		end,
	}) -- }}} ]]

	-- {{{ NeoTree
	use({
		-- "~/repos/neo-tree.nvim",
		"nvim-neo-tree/neo-tree.nvim",
		-- event = "BufRead",
		branch = "v2.x",
		requires = {
			"ThePrimeagen/harpoon", -- optional
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the "open_window_picker" command
				"s1n7ax/nvim-window-picker",
				tag = "v1.*",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
		config = function()
			require("plugins/neo-tree")
		end,
	}) -- }}}

	-- {{{ HOP
	use({
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup({})
		end,
	}) -- }}}

	-- {{{ Bufferline
	use({
		-- 	-- "~/repos/bufferline.nvim",
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		event = "BufWinEnter",
		-- after = "catppuccin",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("plugins/bufferline")
			--[[ require("bufferline").setup({
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
			}) ]]
		end,
	}) -- }}}

	-- {{{ lush
	--[[ use({
		-- "rktjmp/lush.nvim",
		"~/repos/lush.nvim",
	}) -- }}} ]]

	-- {{{ lspconfig
	use({
		"neovim/nvim-lspconfig",
		-- event = "BufRead",
		config = function()
			require("plugins/lspconfig")
		end,
	}) -- }}}

	-- {{{ mason lsp manager
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- event = "BufRead",
		config = function()
			require("plugins/mason")
		end,
	}) -- }}}

	-- {{{ treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		-- "/home/snub/repos/nvim-treesitter",
		-- run = "TSUpdateSync",
		run = function()
			--[[ local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update() ]]
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		-- event = "BufRead",
		requires = {
			-- debug stuff
			{
				"nvim-treesitter/playground",
				after = "nvim-treesitter",
				cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" },
			},

			-- moar textobjects
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = "BufRead",
				after = "nvim-treesitter",
			},

			-- context aware commentstring
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				-- after = "winston0410/commented.nvim",
			},

			-- refactor
			{
				"nvim-treesitter/nvim-treesitter-refactor",
				after = "nvim-treesitter",
			},

			-- autotag
			{
				"windwp/nvim-ts-autotag",
				after = "nvim-treesitter",
			},

			-- docs
			{
				"nvim-treesitter/nvim-tree-docs",
				after = "nvim-treesitter",
			},

			-- query
			{
				"nvim-treesitter/tree-sitter-query",
				after = "nvim-treesitter",
			},
		},
		config = function()
			require("plugins/treesitter")
		end,
	}) -- }}}

	-- {{{ cmp
	use({
		"hrsh7th/nvim-cmp",
		-- "~/repos/nvim-cmp",
		-- event = "CursorMove",
		requires = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			-- "~/repos/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			{
				"L3MON4D3/LuaSnip",
				tag = "v<CurrentMajor>.*",
				config = function()
					require("plugins/luasnip")
				end,
			},
			-- "~/repos/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- {
			-- 	"~/repos/vim-vsnip",
			-- 	event = "BufRead",
			-- 	setup = function()
			-- 		require("plugins/vsnip")
			-- 	end,
			-- },
			-- {
			-- 	"hrsh7th/vim-vsnip-integ",
			-- }, -- vsnip
			-- "hrsh7th/cmp-vsnip", -- coba pake vsnip
			-- "hrsh7th/cmp-copilot",
			-- "~/repos/cmp-copilot",
			--[[ {
				"tzachar/cmp-tabnine",
				run = "./install.sh",
				requires = "hrsh7th/nvim-cmp",
			}, ]]
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			require("plugins/cmp")
		end,
	}) -- }}}

	-- {{{ lspkind - icons
	--  use({
	--  "onsails/lspkind-nvim",
	--  config = function()
	--  require("plugins/cmp")
	--  end,
	--  }) -- }}}

	-- {{{ autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				map_cr = true, --  map <CR> on insert mode
				map_complete = true, -- it will auto insert `(` after select function or method item
				auto_select = true, -- automatically select the first item
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- local cmp = require("cmp")
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	}) -- }}}

	-- {{{ copilot
	--[[ use({
		"github/copilot.vim",
		-- "~/repos/copilot.vim",
	}) -- }}} ]]

	-- {{{ copilot lua
	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup()
	-- 		end, 100)
	-- 	end,
	-- })
	-- }}}

	-- {{{ copilot cmp
	-- use ({
	--    "zbirenbaum/copilot-cmp",
	--    module = "copilot_cmp",
	-- }) --}}}

	-- {{{ colorizer
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			-- require("colorizer").setup()
			require("plugins/colorizer")
		end,
	}) -- }}}

	-- {{{ commenter
	use({
		--  "winston0410/commented.nvim",
		--  event = "BufRead",
		--  config = function()
		--  require("plugins/commented")
		--  end,

		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("plugins/comment")
		end,
	}) -- }}}

	-- {{{ surround / sandwich
	use({
		"ur4ltz/surround.nvim",
		event = "BufRead",
		config = function()
			require("surround").setup({
				context_offset = 100,
				load_autogroups = false,
				mappings_style = "sandwich",
				map_insert_mode = true,
				quotes = { "'", '"' },
				brackets = { "(", "{", "[" },
				space_on_closing_char = false,
				space_on_alias = false,
				pairs = {
					--[[ nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
					linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } }, ]]
					nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
					linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } },
				},
				prefix = "s",
			})
		end,

		-- "kylechui/nvim-surround",
		-- tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		-- config = function()
		-- 	require("nvim-surround").setup({
		-- 		-- Configuration here, or leave empty to use defaults
		-- 	})
		-- end,
	}) -- }}}

	-- {{{ tokyonight themes
	use({
		-- 	"folke/tokyonight.nvim",
		"DimasPradana/tokyonight.nvim",
		-- 	--  event = "ColorSchemePre",
		config = function()
			require("plugins/tokyonight")
		end,
	}) -- }}}

	-- {{{ catppuccin themes
	-- use({
	-- 	"catppuccin/nvim",
	-- 	-- tag = "dev",
	-- 	as = "catppuccin",
	-- 	config = function()
	-- 		require("plugins/catppuccin")
	-- 	end,
	-- }) -- }}}

	-- {{{ indent line
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins/blankline")
		end,
	}) -- }}}

	-- {{{ formatter
	-- use({
	-- 	"sbdchd/neoformat",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		vim.g.neoformat_try_node_exe = 1
	-- 		vim.g.neoformat_verbose = 1
	-- 		-- vim.g.neoformat_run_all_formatters = 1
	-- 	end,
	-- }) -- }}}

	-- {{{ nvim notify
	use({
		-- "~/repos/nvim-notify",
		"rcarriga/nvim-notify",
		-- event = "BufRead",
		config = function()
			require("plugins/notify")
		end,
	}) -- }}}

	-- {{{ smooth scrolling
	--  use({
	--  "karb94/neoscroll.nvim",
	--  event = "BufRead",
	--  config = function()
	--  require('neoscroll').setup({
	--  -- All these keys will be mapped to their corresponding default scrolling animation
	--  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
	--  '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
	--  hide_cursor = true,          -- Hide cursor while scrolling
	--  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
	--  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	--  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	--  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	--  easing_function = nil,        -- Default easing function
	--  pre_hook = nil,              -- Function to run before the scrolling animation starts
	--  post_hook = nil,              -- Function to run after the scrolling animation ends
	--  })
	--  end,
	--  }) -- }}}

	-- {{{ search box
	-- use({
	--    "VonHeikemen/searchbox.nvim",
	--    event = "BufRead",
	--    requires = {
	--      {'MunifTanjim/nui.nvim'}
	--    },
	--    config = function()
	--      require("searchbox").setup({
	--        popup = {
	--            relative = 'win',
	--            -- relative = 'cursor',
	--            -- relative = 'editor',
	--            position = {
	--              row = '5%',
	--              col = '95%',
	--            },
	--            size = 30,
	--            border = {
	--              style = 'rounded',
	--              highlight = 'FloatBorder',
	--              text = {
	--                top = ' CARI ',
	--                -- top_align = 'left',
	--                top_align = 'right',
	--              },
	--            },
	--            win_options = {
	--              winhighlight = 'Normal:Normal',
	--            },
	--          },
	--        hooks = {
	--          before_mount = function(input)
	--            -- code
	--          end,
	--          after_mount = function(input)
	--            -- code
	--          end
	--        }
	--      })
	--    end,
	-- }) -- }}}

	-- {{{ ssh distant
	use({
		"chipsenkbeil/distant.nvim",
		event = "VimEnter",
		config = function()
			require("distant").setup({
				-- Applies Chip's personal settings to every machine you connect to
				--
				-- 1. Ensures that distant servers terminate with no connections
				-- 2. Provides navigation bindings for remote directories
				-- 3. Provides keybinding to jump into a remote file's parent directory
				["*"] = require("distant.settings").chip_default(),
			})
		end,
	}) -- }}}

	-- {{{ null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		-- event = "BufRead",
		-- cmd = "null_ls",
		config = function()
			require("plugins/null-ls")
		end,
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	}) -- }}}

	-- {{{ which key
	use({
		-- "~/repos/which-key.nvim/",
		"folke/which-key.nvim",
		event = "BufWinEnter",
		config = function()
			require("plugins/which_key")
		end,
	}) -- }}}

	-- {{{ git signs
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function()
			require("plugins/gitsigns")
		end,
	}) -- }}}

	-- {{{ markdown preview
	use({
		"ellisonleao/glow.nvim",
		event = "BufWinEnter",
		config = function()
			-- require("plugins/gitsigns")
		end,
	}) -- }}}

	-- {{{ lualine
	--[[ use({
		"~/repos/lualine.nvim",
		event = "VimEnter",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins/lualine")
		end,
	}) --}}} ]]

	-- {{{ virtual-text
	--[[ use({
		"haringsrob/nvim_context_vt",
		event = "BufRead",
		-- config = function()
		-- 	require("plugins/nvim_context_vt")
		-- end,
	}) --}}} ]]

	-- {{{ todo comments
	use({ -- ISSUE(coba pakai todo-comments): fixed by snub on Wed 12 Jan 2022 10:41:15
		"folke/todo-comments.nvim",
		-- cmd = "todo_comments",
		event = "VimEnter",
		requires = { "nvim.lua/plenary.nvim" },
		config = function()
			-- {{{ pake file
			require("plugins/todo-comments") -- pake file
			-- }}}

			-- {{{ embedded command
			-- 	require("todo-comments").setup({
			-- 		-- your configuration comes here
			-- 		-- or leave it empty to use the default settings
			-- 		-- refer to the configuration section below
			-- 		signs = true, -- show icons in the signs column
			-- 		sign_priority = 8, -- sign priority
			-- 		-- keywords recognized as todo comments
			-- 		keywords = {
			-- 			FIX = {
			-- 				icon = " ", -- icon used for the sign, and in search results
			-- 				color = "error", -- can be a hex color, or a named color (see below)
			-- 				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- 				-- signs = false, -- configure signs for some keywords individually
			-- 			},
			-- 			TODO = { icon = " ", color = "info" },
			-- 			HACK = { icon = " ", color = "warning" },
			-- 			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			-- 			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			-- 			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			-- 		},
			-- 		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- 		-- highlighting of the line containing the todo comment
			-- 		-- * before: highlights before the keyword (typically comment characters)
			-- 		-- * keyword: highlights of the keyword
			-- 		-- * after: highlights after the keyword (todo text)
			-- 		highlight = {
			-- 			before = "", -- "fg" or "bg" or empty
			-- 			keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
			-- 			after = "fg", -- "fg" or "bg" or empty
			-- 			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			-- 			comments_only = true, -- uses treesitter to match keywords in comments only
			-- 			max_line_len = 400, -- ignore lines longer than this
			-- 			exclude = {}, -- list of file types to exclude highlighting
			-- 		},
			-- 		-- list of named colors where we try to extract the guifg from the
			-- 		-- list of hilight groups or use the hex color if hl not found as a fallback
			-- 		colors = {
			-- 			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			-- 			warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
			-- 			info = { "DiagnosticInfo", "#2563EB" },
			-- 			hint = { "DiagnosticHint", "#10B981" },
			-- 			default = { "Identifier", "#7C3AED" },
			-- 		},
			-- 		search = {
			-- 			command = "rg",
			-- 			args = {
			-- 				"--color=never",
			-- 				"--no-heading",
			-- 				"--with-filename",
			-- 				"--line-number",
			-- 				"--column",
			-- 			},
			-- 			-- regex that will be used to match keywords.
			-- 			-- don't replace the (KEYWORDS) placeholder
			-- 			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			-- 			-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			-- 		},
			-- 	}) -- }}}
		end,
	}) --}}}

	-- {{{ pretty-fold
	--[[ use({
		"anuvyklack/pretty-fold.nvim",
		event = "BufRead",
		config = function()
			require("plugins/pretty-fold")
		end,
	}) --}}} ]]

	-- {{{ GPS
	--[[ use({
		"SmiteshP/nvim-gps",
		event = "BufRead",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins/gps")
		end,
	}) --}}} ]]

	-- {{{ navic
	use({
		"SmiteshP/nvim-navic",
		-- event = "BufRead",
		requires = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("plugins/navic")
		end,
	}) --}}}

	-- {{{ tabularize
	use({
		"godlygeek/tabular",
		event = "BufRead",
		config = function()
			-- require("plugins/gitsigns")
		end,
	}) -- }}}

	-- {{{ vim-blade
	use({
		"jwalton512/vim-blade",
		event = "BufRead",
		filetype = { "laravel" },
		config = function()
			-- require("plugins/gitsigns")
		end,
	}) -- }}}

	-- {{{ symbol outline like tagbar
	use({
		"simrat39/symbols-outline.nvim",
		-- event = "BufRead",
		config = function()
			require("plugins/symbols-outline")
		end,
	}) -- }}}

	-- {{{ winbar show function
	--[[ use({
		"fgheng/winbar.nvim",
		event = "BufRead",
		config = function()
			require("plugins/winbar")
		end,
	}) -- }}} ]]

	-- {{{ noice/noise
	--[[ use({ -- -> buggy with lsp phpactor
		"folke/noice.nvim",
		config = function()
			require("noice").setup()
			-- require("plugins/noice")
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	}) -- }}} ]]

	-- {{{ golang
	use({
		"ray-x/guihua.lua",
		config = function()
			require("go").setup()
		end,
		requires = {
			"ray-x/go.nvim",
		},
	}) -- }}}

	-- {{{ signature help
	use({
		"ray-x/lsp_signature.nvim",
		-- config = function()
		-- 	require("go").setup()
		-- end,
	}) -- }}}

	-- {{{ yank yank yank
	--[[ use({
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	}) -- }}} ]]

	-- {{{ undotree
	use({
		"jiaoshijie/undotree",
		event = "BufRead",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins/undotree")
		end,
	}) -- }}}

	-- {{{ sqls
	use({
		"nanotee/sqls.nvim",
	}) -- }}}

	-- {{{ chatGPT
	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			-- require("chatgpt").setup({
			require("plugins/chatgpt")
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	--[[ use({
		"aduros/ai.vim",
		config = function() end,
	}) ]]
	-- }}}

	-- FIXME: nvim-lsp code_actions, diagnostics, hover, references, rename, signature, symbol_resolve, workspace_symbol not working yet
end)

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
