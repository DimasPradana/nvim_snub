local sumneko_root = os.getenv("HOME") .. "/repos/lua-language-server"
local c = require("lsp/utils")

require("lspconfig").sumneko_lua.setup({
	cmd = {
		sumneko_root .. "/bin/Linux/lua-language-server",
		"-E",
		sumneko_root .. "/main.lua",
	},
	root_dir = c.custom_cwd,
	settings = {
		Lua = {
			completion = {
				enable = true,
				callSnippet = "Replace",
			},
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			telemetry = {
				enable = false,
			},
			diagnostics = {
				enable = true,
				globals = { "vim", "awesome", "use", "client", "root", "s", "screen" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					["/usr/share/awesome/lib"] = true,
					["/usr/share/lua/5.1"] = true,
					["/usr/share/lua/5.3"] = true,
					["/usr/share/lua/5.4"] = true,
				},
			},
		},
	},
	on_attach = function()
		require("notify")("LSP lua aktif pak", "info")
	end,
})
