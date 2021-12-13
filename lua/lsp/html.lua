local c = require("lsp/utils")

require("lspconfig").html.setup({
	cmd = {
		"html-languageserver",
		"--stdio",
	},
	root_dir = c.custom_cwd,
	on_attach = function()
		require("notify")("LSP html aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
