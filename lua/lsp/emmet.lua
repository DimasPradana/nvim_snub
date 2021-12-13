local c = require("lsp/utils")

require("lspconfig").emmet_ls.setup({
  cmd = {
    "emmet_ls", "--stdio"
  },
  filetypes = {
    "html",
    "css",
    "svelte",
  },
	on_attach = function()
		require("notify")("LSP emmet aktif pak", "info")
	end,
})
-- local lspconfig = require('lspconfig')

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
