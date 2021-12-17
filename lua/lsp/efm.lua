local c = require("lsp/utils")

require("lspconfig").efm.setup({
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			lua = {
				{
					formatCommand = "lua-format -i",
					formatStdin = true,
				},
			},
		},
	},
	-- You must populate this according to the EFM readme
	filetypes = { "python", "cpp", "lua" },
	cmd = { "efm-langserver" },
	root_dir = c.custom_cwd,
	single_file_support = false,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
