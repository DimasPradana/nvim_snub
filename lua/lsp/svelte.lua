-- local c = require("lsp/utils")

require("lspconfig").svelte.setup({
	on_attach = function(client)
		require("notify")("LSP svelte aktif pak", "info")
		client.server_capabilities.completionProvider.triggerCharacters = {
			".",
			'"',
			"'",
			"`",
			"/",
			"@",
			"*",
			"#",
			"$",
			"+",
			"^",
			"(",
			"[",
			"-",
			":",
		}
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
		-- vim.api.nvim_buf_set_keymap(0, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
	end,
	-- function()
	-- 	require("notify")("LSP svelte aktif pak", "info")
	-- end,
	filetypes = { "svelte" },
	settings = {
		svelte = {
			plugin = {
				html = { completions = { enable = true, emmet = false } },
				svelte = { completions = { enable = true, emmet = false } },
				css = { completions = { enable = true, emmet = false } },
			},
		},
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
