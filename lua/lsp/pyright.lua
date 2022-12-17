-- local c = require("lsp/utils")
local navic = require("nvim-navic")

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
	on_attach = function(client, bufnr)
		require("notify")("LSP python aktif pak", "info")
		navic.attach(client, bufnr)
    require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
    }, bufnr)  -- Note: add in lsp client on-attach
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
