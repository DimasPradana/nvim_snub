local Utils = require("utils")

local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local nmap = Utils.tnoremap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- {{{ Delete Buffer
nnoremap("<A-j>", ":bd<CR>") -- }}}

-- {{{ jk to normal mode
inoremap("jk", "<Esc>")
tnoremap("jk", "<C-\\><C-n>") -- }}}

-- {{{ Yank to end of line
nnoremap("Y", "y$") -- }}}

-- {{{ Copy to system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y') -- }}}

-- {{{ Center Next, Prev and Line Concatenate
-- nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
-- nnoremap("J", "mzJ`z") -- }}}

-- {{{ Deal with word wraps
exprnnoremap("k", "v:count == 0 ? 'gk' : 'k'")
exprnnoremap("j", "v:count == 0 ? 'gj' : 'j'") -- }}}

-- {{{ telescope
nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').grep_string()<cr>") -- get string on cursor at current working directory
nnoremap("<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<cr>") -- get file from text input on current working directory
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>") -- }}}

-- {{{ nvim-tree
nnoremap("<C-n>", "<cmd>NvimTreeToggle<cr>")
nnoremap("<leader>r", "<cmd>NvimTreeRefresh<cr>") -- }}}

-- {{{ hop
nnoremap("<leader>hw", "<cmd>lua require('hop').hint_words()<cr>") -- hint words
nnoremap("<leader>hp", "<cmd>lua require('hop').hint_patterns()<cr>") -- hint pattern
nnoremap("<leader>hl", "<cmd>lua require('hop').hint_lines()<cr>") -- hint line
nnoremap("<leader>hc", "<cmd>lua require('hop').hint_char2()<cr>") -- hint char -- }}}

-- {{{ bufferline
nnoremap("<A-l>", "<cmd>BufferLineCycleNext<cr>") -- next
nnoremap("<A-h>", "<cmd>BufferLineCyclePrev<cr>") -- previous -- }}}

-- {{{ packer
nnoremap("<leader>ps", "<cmd>PackerSync<cr>") -- packer sync
nnoremap("<leader>pc", "<cmd>PackerCompile<cr>") -- packer sync -- }}}

-- {{{ node
nnoremap("<leader>nod", "<cmd>!tmux split-window 'npm run dev'; read;<cr>") -- svelte run development
nnoremap("<leader>nop", "<cmd>!node build/index.js<cr>") -- node build index js -- }}}

-- {{{ lua
nnoremap("<leader>lua", "<cmd>echo 'source lua success' | luafile %<cr>") -- source lua -- }}}

-- {{{ formatter
nnoremap("<leader>fm", "<cmd>Neoformat<cr>") -- run neoformat -- }}}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
