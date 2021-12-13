local c = require("lsp/utils")

require("lspconfig").tsserver.setup({
	root_dir = c.custom_cwd,
	settings = {
		tsserver = {
			useBatchedBufferSync = true,
		},
		javascript = {
			autoClosingTags = true,
			suggest = {
				autoImports = true,
			},
			updateImportsOnFileMove = {
				enable = true,
			},
		},
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	on_attach = function()
		require("notify")("LSP tsserver aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
