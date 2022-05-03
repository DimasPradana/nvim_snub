vim.cmd([[ packadd null-ls ]])
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        { textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
        function(err, res)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                vim.lsp.util.apply_text_edits(res, bufnr)
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

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

	--[[ on_attach = function(client)
		if client.resolved_capabilities.documet_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end, ]]
 -- add your sources / config options here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function(bufnr)
                    async_formatting(bufnr)
                end,
            })
        end
    end,})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
