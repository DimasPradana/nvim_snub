require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"tsx",
		"typescript",
		"javascript",
		"graphql",
		"html",
		"css",
		"json",
		"jsonc",
		"rust",
		"go",
		"svelte",
		"php",
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	refactor = {
		highlight_definitions = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				list_definitions_toc = "gO",
				goto_next_usage = "<a-*>",
				goto_previous_usage = "<a-#>",
			},
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {},
		lsp_interop = {},
		--[[ builtn-in :
        @block.inner
        @block.outer
        @call.inner
        @call.outer
        @class.inner
        @class.outer
        @comment.outer
        @conditional.inner
        @conditional.outer
        @frame.inner
        @frame.outer
        @function.inner
        @function.outer
        @loop.inner
        @loop.outer
        @parameter.inner
        @parameter.outer
        @scopename.inner
        @statement.outer ]]
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	context_commentstring = {
		enable = true,
		-- This plugin provided an autocommand option
		-- enable_autocmd = true,
	},
	tree_docs = {
		enable = true,
		spec_config = {
			svelte = {
				slots = {
					class = { author = true },
				},
				processors = {
					author = function()
						return " * @author SNUB"
					end,
				},
			},
			jsdoc = {
				slots = {
					class = { author = true },
				},
				processors = {
					author = function()
						return " * @author SNUB"
					end,
				},
			},
			lua = {
				slots = {
					class = { author = true },
				},
				processors = {
					author = function()
						return " * @author SNUB"
					end,
				},
			},
		},
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
