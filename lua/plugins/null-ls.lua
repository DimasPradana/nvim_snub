vim.cmd([[ packadd null-ls ]])
local null_ls = require("null-ls")

null_ls.setup({
	-- sources = {
	-- 	-- null_ls.builtins.code_actions,
	-- 	-- null_ls.builtins.formatting.stylua,
	--    -- null_ls.builtins.diagnostics.eslint,
	-- 	-- null_ls.builtins.completion.spell,
	-- 	-- null_ls.builtins.formatting,
	-- 	-- null_ls.builtins.diagnostics,
	-- 	--[[ null_ls.builtins.diagnostics.eslint.with({
	--      diagnostics_format = "[#{c}] #{m} (#{s})",
	--    }), ]]
	-- 	null_ls.builtins.completion,
	-- 	null_ls.builtins.formatting.prettier.with({
	-- 		filetypes = { "html", "json", "lua", "markdown", "php", "yaml", "blade" },
	-- 		extra_filetypes = { "svelte", "toml" },
	-- 	}),
	-- 	--[[ require("null-ls.helpers").conditional(function(utils)
	-- 		return utils.root_has_file(".eslintrc.js") and require("null-ls").builtins.formatting.eslint_d
	-- 			or require("null-ls").formatting.prettier
	-- 	end), ]]
	-- 	null_ls.builtins.formatting.eslint_d.with({
	-- 		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
	-- 	}),
	-- },
	-- on_attach = function(client)
	-- 	if client.resolved_capabilities.documet_formatting then
	-- 		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	-- 	end
	-- end,
	--
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "lua", "markdown", "php", "yaml", "blade" },
			extra_filetypes = { "svelte", "toml" },
		}),
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.phpcbf,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.php,
	},

	on_attach = function(client)
		if client.resolved_capabilities.documet_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
