local c = require("lsp/utils")

require("lspconfig").gopls.setup({
	cmd = { "gopls", "serve" },
	root_dir = c.custom_cwd,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			codelenses = {
				references = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				generate = true,
			},
			gofumpt = true,
		},
	},
	-- auto commands
	auto_format = true,
	-- auto_lint = true,
	-- linters: golint, errcheck, staticcheck, golangci-lint
	-- linter = 'golint',
	-- lint_prompt_style: qf (quickfix), vt (virtual text)
	-- lint_prompt_style = 'qf',
	-- formatter: goimports, gofmt, gofumpt
	formatter = "goimports",
	-- test flags: -count=1 will disable cache
	test_flags = { "-v" },
	test_timeout = "30s",
	test_env = {},
	-- show test result with popup window
	test_popup = true,
	-- struct tags
	tags_name = "json",
	tags_options = { "json=omitempty" },
	tags_transform = "snakecase",
	tags_flags = { "-skip-unexported" },
	-- quick type
	quick_type_flags = { "--just-types" },
	on_attach = function()
		require("notify")("LSP golang aktif pak", "info")
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
		-- vim.api.nvim_buf_set_keymap(0, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
		-- vim.api.nvim_buf_set_keymap(0, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true })
		-- vim.api.nvim_buf_set_keymap(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
	end,
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
