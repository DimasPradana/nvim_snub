require("../plugins.test")

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
					dataSourceName = "root:s1tubond0^@tcp(103.165.156.165:28)/",
				},
				{
					driver = "mysql",
					alias = "vtax GW",
					dataSourceName = "bapendaSync:s1_BAPENDA-81^@tcp(103.165.156.165:617)/GW_PBB",
				},
				{
					driver = "mysql",
					alias = "vtax SW",
					dataSourceName = "bapendaSync:s1_BAPENDA-81^@tcp(103.165.156.165:617)/SW_PBB",
				},
			},
		},
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
