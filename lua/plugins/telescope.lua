vim.cmd([[ packadd telescope.nvim ]])

require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				-- ["<C-h>"] = "which_key"
			},
			n = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				-- ["<C-h>"] = "which_key"
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
		find_files = {
			theme = "dropdown",
			prompt_prefix = "🔍",
			find_command = {
				"rg",
				"--ignore",
				"--hidden",
				"--files",
			},
		},
		--[[ grep_string = {
			theme = "cursor",
			find_command = {
				"ag",
			},
		}, ]]
		live_grep = {
			theme = "dropdown",
			find_command = {
				"ag",
			},
		},
		buffers = {
			theme = "ivy",
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		-- lsp_handlers = {
		-- 	disable = {},
		-- 	location = {
		-- 		telescope = {},
		-- 		no_results_message = "No references found",
		-- 	},
		-- 	symbol = {
		-- 		telescope = {},
		-- 		no_results_message = "No symbols found",
		-- 	},
		-- 	call_hierarchy = {
		-- 		telescope = {},
		-- 		no_results_message = "No calls found",
		-- 	},
		-- 	code_action = {
		-- 		telescope = {
		-- 			require("telescope.themes").get_dropdown({}), -- contoh untuk dropdown
		-- 		},
		-- 		no_results_message = "No code actions available",
		-- 		prefix = "",
		-- 	},
		-- },
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
	layout_config = {
		horizontal = {
			prompt_position = "top",
			preview_width = 0.55,
			results_width = 0.8,
		},
		vertical = {
			mirror = false,
		},
		width = 0.87,
		height = 0.80,
		preview_cutoff = 120,
	},
})

-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
