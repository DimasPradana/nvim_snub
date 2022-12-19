-- load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/repos/friendly-snippets" } })
-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
