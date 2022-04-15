-- local c = require("lsp/utils")

require("lspconfig").svelte.setup({
	on_attach = function(client)
		client.server_capabilities.completionProvider.triggerCharacters =
			{
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
			}, require("notify")("LSP svelte aktif pak", "info")
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
