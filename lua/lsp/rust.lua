local c = require("lsp/utils")
local navic = require("nvim-navic")

require("lspconfig").rust_analyzer.setup({
	root_dir = c.custom_cwd,
	settings = {
    ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
            }
      },
	--[[ filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	}, ]]
	on_attach = function(client, bufnr)
		require("notify")("LSP rust aktif pak", "info")
		-- vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
		navic.attach(client, bufnr)
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
