--  TODO: snub on Sun 18 Dec 2022 02:13:59 : dataSourceName harus ambil dari .env file, tidak di plain
require("lspconfig").sqls.setup({
	on_attach = function(client, bufnr)
		require("sqls").on_attach(client, bufnr)
	end,
	settings = {
		sqls = {
			connections = {
				{
					driver = "mysql",
					alias = "SVR14",
				},
				{
					driver = "mysql",
					alias = "vtax GW",
				},
				{
					driver = "mysql",
					alias = "vtax SW",
				},
			},
		},
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
