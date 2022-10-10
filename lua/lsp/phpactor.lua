local c = require("lsp/utils")
local navic = require("nvim-navic")

require("lspconfig").phpactor.setup({
  cmd = { "phpactor", "language-server" },
  filetypes = { "php" },
  root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
  on_attach = function(client, bufnr)
    require("notify")("LSP phpactor aktif pak", "info")
    navic.attach(client, bufnr)
  end,
  init_options = {
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
  }
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
