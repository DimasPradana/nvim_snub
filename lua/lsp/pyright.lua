-- local c = require("lsp/utils")

require("lspconfig").pyright.setup({
	settings = {
		python = {
			analysis = {
				useLibraryCodeForTypes = true,
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "basic",
			},
		},
	},
	on_attach = function()
		require("notify")("LSP python aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
