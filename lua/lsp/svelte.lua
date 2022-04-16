-- local c = require("lsp/utils")

require("lspconfig").svelte.setup({
	on_attach = function(client)
		require("notify")("LSP svelte aktif pak", "info")
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
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
