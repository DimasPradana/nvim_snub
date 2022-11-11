vim.cmd([[ packadd nvim-cmp ]])

local cmp = require("cmp")
local lspkind = require("lspkind")
local buffer = require("cmp_buffer")
-- local tabnine = require("cmp_tabnine.config")

-- Copilot
-- vim.b.copilot_enabled = false
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true

-- vim.api.nvim_set_keymap("i", "<right>", 'copilot#Accept("")', { expr = true, silent = true })

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-Space>"] = cmp.mapping.complete(),
		-- ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
		["<CR>"] = function(fallback)
			if cmp.visible() then
				cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })(fallback)
			else
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "vsnip" },
		{
			name = "buffer",
			keyword_length = 6,
			option = {
				get_bufnrs = function()
					return { vim.api.nvim_get_current_buf() }
				end,
			},
		},
		{ name = "path", keyword_length = 2 },
		{ name = "nvim_lua" },
		-- { name = "copilot" },
		{ name = "nvim_lsp_signature_help" },
		-- { name = "cmp_tabnine" },
	}),
	preselect = cmp.PreselectMode.None,
	view = {
		entries = {
			--[[ name = "wildmenu",
			separator = " | ", ]]
			name = "custom",
			selection_order = "near_cursor",
			-- name = "native",
		},
	},
	formatting = {
		format = lspkind.cmp_format({
			-- mode = "symbol_text",
			mode = "text_symbol",
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				vsnip = "[VSNIP]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				file = "[FILE]",
				-- copilot = "[Copilot]",
				-- cmp_tabnine = "[TN]",
			},
		}),
	},
	sorting = {
		comparators = {
			function(...)
				return buffer:compare_locality(...)
			end,
			-- The rest of your comparators...
		},
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		-- { name = "copilot" },
		{ name = "nvim_lsp_document_symbol" },
	}, {
		{ name = "buffer" },
	}),
	view = {
		entries = {
			name = "wildmenu",
			separator = " | ",
			-- name = "custom",
			selection_order = "near_cursor",
			-- name = "native",
		},
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	},
	view = {
		entries = {
			name = "wildmenu",
			separator = " | ",
			-- name = "custom",
			selection_order = "near_cursor",
			-- name = "native",
		},
	},
})

--[[ tabnine.setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
	ignored_file_types = {
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
	show_prediction_strength = false,
}) ]]

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
