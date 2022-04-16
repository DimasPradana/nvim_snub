local c = require("lsp/utils")

require("lspconfig").intelephense.setup({
	root_dir = c.custom_cwd,
	on_attach = function()
		require("notify")("LSP intelephense aktif pak", "info")
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
