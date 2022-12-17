-- vim.cmd([[ packadd null-ls ]])
local null_ls = require("null-ls")
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
		-- null_ls.builtins.code_actions.eslint,
		-- null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.php,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.blade_formatter.with({
			filetypes = { "blade" },
		}),
		null_ls.builtins.formatting.stylua.with({
			filetypes = { "lua" },
		}),
		--[[ null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "markdown", "php", "yaml" },
			extra_filetypes = { "svelte", "toml" },
		}), ]]
		null_ls.builtins.formatting.prettierd.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"markdown.mdx",
				"graphql",
				"handlebars",
			},
			-- extra_filetypes = { "svelte", "toml" },
		}),
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports,
		-- null_ls.builtins.diagnostics.pylint.with({
		-- 	diagnostics_postprocess = function(diagnostic)
		-- 		diagnostic.code = diagnostic.message_id
		-- 	end,
		-- }),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		-- null_ls.builtins.formatting.eslint,
		--[[ null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.phpcbf, ]]
	},

	--[[ on_attach = function(client)
		if client.resolved_capabilities.documet_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end, ]]
	-- add your sources / config options here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
