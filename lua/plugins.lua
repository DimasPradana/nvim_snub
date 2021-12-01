vim.cmd([[packadd packer.nvim]]) -- Load Packer

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
		"/home/snub/repos/telescope.nvim",
		event = "VimEnter",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			-- "nvim-telescope/telescope-frecency.nvim",
			-- "nvim-telescope/telescope-media-files.nvim",
			-- "nvim-telescope/telescope-fzy-native.nvim",
		},
		config = function()
			require("plugins/telescope")
		end,
	}) -- }}}

	-- {{{ NvimTree
	use({
		"kyazdani42/nvim-tree.lua",
		event = "BufRead",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("plugins/nvim-tree")
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
		"akinsho/bufferline.nvim",
		event = "BufWinEnter",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("plugins/bufferline")
		end,
	}) -- }}}

	-- {{{ lush
	use({
		"rktjmp/lush.nvim",
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
		run = ":TSUpdate",
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
		},
		config = function()
			require("plugins/treesitter")
		end,
	}) -- }}}

	-- {{{ cmp
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins/cmp")
		end,
	}) -- }}}

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
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	}) -- }}}

	-- {{{ copilot
	use({
		"github/copilot.vim",
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
		"winston0410/commented.nvim",
		event = "BufRead",
		config = function()
			require("plugins/commented")
		end,
	}) -- }}}

	-- {{{ surround / sandwich
	use({
		"blackCauldron7/surround.nvim",
		event = "BufRead",
		config = function()
			require("surround").setup({
				context_offset = 100,
				load_autogroups = false,
				mappings_style = "sandwich",
				map_insert_mode = true,
				quotes = { "'", '"' },
				brackets = { "(", "{", "[" },
				pairs = {
					nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
					linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } },
				},
				prefix = "s",
			})
		end,
	}) -- }}}

	-- {{{ tokyonight themes
	use({
		"folke/tokyonight.nvim",
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
	use({
		"sbdchd/neoformat",
		event = "BufRead",
		--  config = function()
		--  require("plugins/blankline")
		--  end,
	}) -- }}}

	-- TODO nvim notify
	-- {{{ nvim notify
	use({
     "~/repos/nvim-notify",
      event = "BufRead",
	--  config = function()
	--  require("plugins/blankline")
	--  end,
	}) -- }}}

	-- TODO neovim bootstraping
end)

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
