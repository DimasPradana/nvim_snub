local c = require("lsp/utils")

require("lspconfig").cssls.setup({
	cmd = {
		"css-languageserver",
		"--stdio",
	},
	root_dir = c.custom_cwd,
	on_attach = function()
		require("notify")("LSP cssls aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
