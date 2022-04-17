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
	use({
		"tweekmonster/startuptime.vim",
		event = "VimEnter",
	}) -- }}}

	-- {{{ Filetype replacement
	use({
		"nathom/filetype.nvim",
	}) -- }}}

	-- {{{ vim motion case sensitive
	use({
		"chaoren/vim-wordmotion",
		event = "BufRead",
	}) -- }}}

	-- {{{ Telescope
	use({
		-- "nvim-telescope/telescope.nvim",
		"~/repos/telescope.nvim",
		event = "VimEnter",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			-- "nvim-telescope/telescope-frecency.nvim",
			-- "nvim-telescope/telescope-media-files.nvim",
			-- "nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			-- "gbrlsnchs/telescope-lsp-handlers.nvim",
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
		"~/repos/neo-tree.nvim",
		event = "BufRead",
		branch = "v2.x",
		requires = {
			"ThePrimeagen/harpoon", -- optional
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the "open_window_picker" command
				"s1n7ax/nvim-window-picker",
				tag = "1.*",
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
		"~/repos/bufferline.nvim",
		-- "akinsho/bufferline.nvim",
		event = "BufWinEnter",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("plugins/bufferline")
		end,
	}) -- }}}

	-- {{{ lush
	use({
		-- "rktjmp/lush.nvim",
		"~/repos/lush.nvim",
	}) -- }}}

	-- {{{ lspconfig
	use({
		"neovim/nvim-lspconfig",
		event = "BufRead",
		config = function()
			require("plugins/lspconfig")
		end,
	}) -- }}}

	-- {{{ treesitter
	use({
		-- "nvim-treesitter/nvim-treesitter",
		"/home/snub/repos/nvim-treesitter",
		run = ":TSUpdateSync",
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
		-- "hrsh7th/nvim-cmp",
		"~/repos/nvim-cmp",
		-- event = "CursorMove",
		requires = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"neovim/nvim-lspconfig",
			-- "hrsh7th/cmp-nvim-lsp",
			"~/repos/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- "L3MON4D3/LuaSnip",
			-- "~/repos/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",
			{
				"~/repos/vim-vsnip",
				event = "BufRead",
				setup = function()
					require("plugins/vsnip")
					-- vim.cmd([[
					--          " Jump forward or backward
					--          imap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
					--          smap <expr> <C-j> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-j>'
					--          imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
					--          smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
					--        " Expand
					--        imap <expr> <C-n>   vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-n>'
					--        ]])
				end,
			},
			{
				"hrsh7th/vim-vsnip-integ",
			}, -- vsnip
			"hrsh7th/cmp-vsnip", -- coba pake vsnip
			-- "hrsh7th/cmp-copilot",
			"~/repos/cmp-copilot",
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
	use({
		-- "github/copilot.vim",
		"~/repos/copilot.vim",
	}) -- }}}

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
			require("Comment").setup({
				---Add a space b/w comment and the line
				---@type boolean
				padding = true,

				---Whether the cursor should stay at its position
				---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
				---@type boolean
				sticky = true,

				---Lines to be ignored while comment/uncomment.
				---Could be a regex string or a function that returns a regex string.
				---Example: Use '^$' to ignore empty lines
				---@type string|function
				-- ignore = nil,
				ignore = "^$",

				---LHS of toggle mappings in NORMAL + VISUAL mode
				---@type table
				toggler = {
					---line-comment keymap
					line = "gcc",
					---block-comment keymap
					block = "gbc",
				},

				---LHS of operator-pending mappings in NORMAL + VISUAL mode
				---@type table
				opleader = {
					---line-comment keymap
					line = "gc",
					---block-comment keymap
					block = "gb",
				},

				---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
				---@type table
				mappings = {
					---operator-pending mapping
					---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
					---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
					basic = true,
					---extra mapping
					---Includes `gco`, `gcO`, `gcA`
					extra = true,
					---extended mapping
					---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
					extended = true,
				},

				---Pre-hook, called before commenting the line
				---@type fun(ctx: Ctx):string
				pre_hook = nil,

				---Post-hook, called after commenting is done
				---@type fun(ctx: Ctx)
				post_hook = nil,
			})
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
	}) -- }}}

	-- {{{ tokyonight themes
	use({
		"folke/tokyonight.nvim",
		--  event = "ColorSchemePre",
		--  config = function()
		--  --  require("plugins/tokyonight")
		--  vim.g.tokyonight_style = "night"
		--  vim.g.tokyonight_italic_functions = true
		--  vim.g.tokyonight_italic_comments = true
		--  vim.g.tokyonight_italic_variables = true
		--  vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
		--  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
		--  vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
		--  -- Load the colorscheme
		--  vim.cmd([[colorscheme tokyonight]])
		--  end,
	}) -- }}}

	-- {{{ indent line
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins/blankline")
		end,
	}) -- }}}

	-- {{{ formatter
	--[[ use({
		"sbdchd/neoformat",
		event = "BufRead",
		--  config = function()
		--  require("plugins/blankline")
		--  end,
	}) -- }}} ]]

	-- {{{ nvim notify
	use({
		"~/repos/nvim-notify",
		event = "BufRead",
		--  config = function()
		--  require("plugins/blankline")
		--  end,
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
		event = "BufRead",
		-- cmd = "null_ls",
		config = function()
			require("plugins/null-ls")
		end,
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	}) -- }}}

	-- {{{ which key
	use({
		"~/repos/which-key.nvim/",
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
	use({
		"~/repos/lualine.nvim",
		event = "VimEnter",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins/lualine")
		end,
	}) --}}}

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

	-- TODO: nvim dashboard
	-- TODO: neovim bootstraping
	-- FIXME: nvim-lsp code_actions, diagnostics, hover, references, rename, signature, symbol_resolve, workspace_symbol not working yet
end)

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
