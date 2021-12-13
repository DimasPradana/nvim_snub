local c = require("lsp/utils")

require "lspconfig".efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {formatCommand = "lua-format -i", formatStdin = true}
            }
        }
    }
}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
