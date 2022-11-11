vim.cmd([[ packadd nvim-lspconfig ]])

local nvim_lsp = require("lspconfig")
local utils = require("lsp/utils")
local common_on_attach = utils.common_on_attach

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true -- emmet_ls

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
local servers = { "clangd", "pyright", "cssls", "jsonls", "html", "svelte" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = common_on_attach,
		capabilities = capabilities,
	})
end

-- set atribute of lsp diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	virtual_text = true,
-- 	signs = signs,
-- })
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
	bufnr = bufnr or 0
	line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
	opts = opts or { ["lnum"] = line_nr }

	local line_diagnostics = vim.diagnostic.get(bufnr, opts)
	if vim.tbl_isempty(line_diagnostics) then
		return
	end

	local diagnostic_message = ""
	for i, diagnostic in ipairs(line_diagnostics) do
		diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
		print(diagnostic_message)
		if i ~= #line_diagnostics then
			diagnostic_message = diagnostic_message .. "\n"
		end
	end
	vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
end

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- set atribute of lsp diagnostics yang gaul
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Enable underline, use default values
	underline = true,
	-- Enable virtual text, override spacing to 4
	virtual_text = false,
	--[[ virtual_text = {
		spacing = 4,
		prefix = "~»",
	}, ]]
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
-- require("lsp/intelephense")
require("lsp/phpactor")
require("lsp/html")
require("lsp/jsonls")
require("lsp/pyright")
-- require("lsp/tailwindcss")
require("lsp/bashls")
require("lsp/svelte")
require("lsp/emmet")
-- require("lsp/cssls")
-- require("lsp/efm")

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
