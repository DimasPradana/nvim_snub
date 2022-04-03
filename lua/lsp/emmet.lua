local c = require("lsp/utils")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").emmet_ls.setup({
	cmd = {
		"emmet-ls",
		"--stdio",
	},
	filetypes = {
		"html",
		"css",
		"svelte",
		"blade",
	},
	root_dir = function(fname)
		return vim.loop.cwd()
	end,
	settings = {},
	on_attach = function()
		require("notify")("LSP emmet aktif pak", "info")
	end,
	capabilities = capabilities,
})
-- local lspconfig = require('lspconfig')

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
