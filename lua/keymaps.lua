local Utils = require("utils")

local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
-- local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
local cnoremap = Utils.cnoremap
-- local nmap = Utils.tnoremap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- {{{ Delete Buffer
nnoremap("<A-j>", ":bd!<CR>") -- }}}

-- {{{ jk to normal mode
inoremap("jk", "<Esc>")
tnoremap("jk", "<C-\\><C-n>")
cnoremap("jk", "<Esc>") -- }}}
-- vnoremap("jk", "<Esc>") -- }}} -- make lagging ;(

-- {{{ Yank to end of line
-- nnoremap("Y", "y$") -- }}}

-- {{{ Copy and paste to system clipboard
--[[ nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>pp", '"+p')
vnoremap("<leader>pp", '"+p') ]]
-- }}}

-- {{{ Center Next, Prev and Line Concatenate
-- nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
-- nnoremap("J", "mzJ`z") -- }}}

-- {{{ Deal with word wraps
exprnnoremap("k", "v:count == 0 ? 'gk' : 'k'")
exprnnoremap("j", "v:count == 0 ? 'gj' : 'j'") -- }}}

-- {{{ bufferline
nnoremap("<A-l>", "<cmd>BufferLineCycleNext<cr>") -- next
nnoremap("<A-h>", "<cmd>BufferLineCyclePrev<cr>") -- previous
-- <C-x> go to file selection as a split
-- <C-v> go to file selection as a vsplit
-- <C-t> go to a file in a new tab -- }}}

-- {{{ navigate between split
-- nnoremap("<A-l>", "<C-W>l")
-- nnoremap("<A-h>", "<C-W>h")
-- nnoremap("<A-k>", "<C-W>k")
-- nnoremap("<A-j>", "<C-W>j") -- }}}

-- {{{ searchbox
-- nnoremap("/", "<cmd>lua require('searchbox').match_all({clear_matches = true})<cr>") -- run searchbox -- }}}

-- {{{ nav when insert and command mode
inoremap("<A-h>", "<left>") -- nav left on insert mode
inoremap("<A-j>", "<down>") -- nav down on insert mode
inoremap("<A-k>", "<up>") -- nav up on insert mode
inoremap("<A-l>", "<right>") -- nav right on insert mode -- }}}

-- {{{ symbols outline
nnoremap("<F10>", ":SymbolsOutline<CR>")
-- }}}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
