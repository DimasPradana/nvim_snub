local sumneko_root = os.getenv("HOME") .. "/repos/lua-language-server"
local c = require("lsp/utils")
local navic = require("nvim-navic")

require("lspconfig").sumneko_lua.setup({
	cmd = {
		-- sumneko_root .. "/bin/Linux/lua-language-server",
		sumneko_root .. "/bin/lua-language-server",
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
	-- on_attach = function(client)
	on_attach = function(client, bufnr)
		require("notify")("LSP lua aktif pak", "info")

		client.server_capabilities.document_formatting = true -- coba null-ls default formatting
		client.server_capabilities.document_range_formatting = true
		--[[ vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true }) ]]
		-- vim.api.nvim_buf_set_keymap(0, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })

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
