vim.cmd([[ packadd nvim-lspconfig ]])

local nvim_lsp = require("lspconfig")
local utils = require("lsp/utils")
local common_on_attach = utils.common_on_attach

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true -- emmet_ls

-- Column Sign for Diagnostics
-- Neovim 0.5+
--[[ local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end ]]

-- Neovim 0.6+
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- Enable the following language servers
local servers = { "clangd", "pyright", "cssls", "jsonls", "html" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = common_on_attach,
		capabilities = capabilities,
	})
end

-- null-ls config
-- local null_ls = require("null-ls")
-- require("null-ls").setup({
-- sources = {
-- null_ls.builtins.formatting.stylua,
-- null_ls.builtins.diagnostics.eslint,
-- null_ls.builtins.completion.spell,
-- null_ls.builtins.formatting.prettier.with({
-- filetypes = {"html", "json", "lua", "markdown", "php", "typescript", "yaml", "blade", "svelte"},
-- })
-- },
-- -- on_attach = function(client)
-- -- 	if client.resolved_capabilities.documet_formatting then
-- -- 		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
-- -- 	end
-- -- end,
-- })

-- set atribute of lsp diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = true,
-- 	signs = signs,
-- })
-- set atribute of lsp diagnostics yang gaul
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Enable underline, use default values
	underline = true,
	-- Enable virtual text, override spacing to 4
	-- virtual_text = false,
	virtual_text = {
		spacing = 4,
		prefix = "~",
	},
	-- Use a function to dynamically turn signs off
	-- and on, using buffer local variables
	signs = function(bufnr, client_id)
		local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, "show_signs")
		-- No buffer local variable set, so just enable by default
		if not ok then
			return true
		end

		return result
	end,
	-- Disable a feature
	update_in_insert = false,
})

require("lsp/tsserver")
require("lsp/gopls")
require("lsp/sumneko")
require("lsp/intelephense")
require("lsp/html")
require("lsp/cssls")
require("lsp/jsonls")
require("lsp/pyright")
-- require("lsp/tailwindcss")
require("lsp/bashls")
require("lsp/svelte")
require("lsp/emmet")
-- require("lsp/efm")

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
