local c = require("lsp/utils")

require("lspconfig").bashls.setup({
	cmd = { "bash-language-server", "start" },
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
	},
	filetypes = { "sh" },
	root_dir = c.custom_cwd,
	on_attach = function()
		require("notify")("LSP bashls aktif pak", "info")
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
