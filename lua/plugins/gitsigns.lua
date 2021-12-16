-- vim.cmd([[ packadd commented ]])

require("gitsigns").setup({
  signs = {
    add          = { hl = "SignAdd",    text = "▎" },
    change       = { hl = "SignChange", text = "▎" },
    delete       = { hl = "SignDelete", text = "🭻" },
    topdelete    = { hl = "SignDelete", text = "🭶" },
    changedelete = { hl = "SignChange", text = "▎" },
  }
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
