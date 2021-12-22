local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")
local lspkind = require("lspkind") -- coba pakai lspkind

-- Copilot
vim.b.copilot_enabled = false
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

-- emmet_ls
vim.g.emmet_ls_enabled = true
vim.g.completion_trigger_characters = { ">", "." }

vim.api.nvim_set_keymap("i", "<right>", 'copilot#Accept("")', { expr = true, silent = true })

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	documentation = {
		border = "solid",
	},

	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[BUF]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[LUA]",
				path = "[PATH]",
				vsnip = "[SNIP]",
			},
			max_width = 50,
		}),
	},

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
			else
				fallback()
			end
		end,
	},

	preselect = cmp.PreselectMode.None,

	sources = {
		{ name = "nvim_lsp" },
		{ name = "vsnip", keyword_length = 2 },
		{ name = "path" },
		{ name = "nvim_lua" },
		{
			name = "buffer",
			keyword_length = 5,
			option = {
				get_bufnrs = function()
					return { vim.api.nvim_get_current_buf() }
				end,
			},
		},
		{ name = "copilot" },
	},

	experimental = {
		native_menu = false,
		ghost_text = true,
	},

	sorting = {
		comparators = {
			function(...)
				return cmp_buffer:compare_locality(...)
			end,
			-- The rest of your comparators...
		},
	},

	completion = {
		keyword_length = 3,
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
