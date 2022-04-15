vim.cmd([[ packadd vim-vsnip ]])
vim.cmd([[
  let g:vsnip_snippet_dir = expand('~/.vsnip')
  let g:vsnip_filetypes = {}
  let g:vsnip_filetypes.javascriptreact = ['javascript']
  let g:vsnip_filetypes.typescriptreact = ['typescript']
]])
-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
