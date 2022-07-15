vim.cmd([[ packadd vim-blade ]])
vim.cmd([[
  let g:blade_custom_directives = ['datetime', 'javascript']
  let g:blade_custom_directives_pairs = {
        \   'markdown': 'endmarkdown',
        \   'cache': 'endcache',
        \ }
]])
