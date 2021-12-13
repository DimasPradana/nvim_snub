local c = require("lsp/utils")

require("lspconfig").jsonls.setup({
	cmd = {
		"json-languageserver",
		"--stdio",
	},
	root_dir = c.custom_cwd,
	on_attach = function()
		require("notify")("LSP jsonls aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
