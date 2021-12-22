-- vim.cmd([[ packadd null-ls ]])

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.completion.spell,
    require("null-ls").builtins.formatting.prettier.with({
      filetypes = {"html", "json", "lua", "markdown", "php", "typescript", "yaml", "blade", "svelte"},
    })
	},
	on_attach = function(client)
		if client.resolved_capabilities.documet_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
