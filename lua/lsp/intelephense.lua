local c = require("lsp/utils")

require("lspconfig").intelephense.setup({
	root_dir = c.custom_cwd,
	on_attach = function()
		require("notify")("LSP intelephense aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
