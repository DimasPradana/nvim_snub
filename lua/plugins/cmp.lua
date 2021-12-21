
local Utils = require("utils")
local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")
local lspkind = require("lspkind") -- coba pakai lspkind

-- local exprinoremap = Utils.exprinoremap

-- Little hacky function I got from —
-- https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/loaders/from_vscode.lua#L173-L180
local function get_snippets_rtp()
	return vim.tbl_map(function(itm)
		return vim.fn.fnamemodify(itm, ":h")
	end, vim.api.nvim_get_runtime_file("package.json", true))
end

local opts = {
	paths = {
		vim.fn.stdpath("config") .. "/snips/",
		get_snippets_rtp()[1],
	},
}

require("luasnip.loaders.from_vscode").lazy_load(opts)

-- Copilot
vim.b.copilot_enabled = false
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

vim.api.nvim_set_keymap("i", "<right>", 'copilot#Accept("")', { expr = true, silent = true })

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	documentation = {
		border = "solid",
	},

	-- TODO ambil dari NvChad cmp config
	--  formatting = {
	--  format = function(entry, vim_item)
	--  -- load lspkind icons
	--  vim_item.kind = string.format("%s %s", require("plugins.lspkind_icons").icons[vim_item.kind], vim_item.kind)

	--  vim_item.menu = ({
	--  nvim_lsp = "[LSP]",
	--  nvim_lua = "[Lua]",
	--  buffer = "[BUF]",
	--  copilot = "[COP]",
	--  path = "[PATH]",
	--  })[entry.source.name]

	--  return vim_item
	--  end,
	--  },
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				buffer = "[BUF]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[LUA]",
				path = "[PATH]",
				luasnip = "[SNIP]",
				-- vsnip = "[SNIP]",
			},
			max_width = 50,
		}),
	},

	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),

		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,

		["<C-Space>"] = cmp.mapping.complete(),

		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-c>"] = cmp.mapping.close(),
	},

	preselect = cmp.PreselectMode.None,

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 2 },
		-- { name = "vsnip", keyword_length = 2 },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 5 },
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
