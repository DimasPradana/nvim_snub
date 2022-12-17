local c = require("lsp/utils")
local navic = require("nvim-navic")

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
	on_attach = function(client, bufnr)
		require("notify")("LSP tsserver aktif pak", "info")
		-- vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
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
