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
  init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})
-- local lspconfig = require('lspconfig')

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
