local Utils = require("utils")

local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
-- local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local tnoremap = Utils.tnoremap
-- local cnoremap = Utils.cnoremap
-- local nmap = Utils.tnoremap

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
nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>") -- get list of buffers
nnoremap("<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>") -- Lists available plugin/user commands and runs them on <cr>
nnoremap("<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>") -- Lists normal mode keymappings
nnoremap("<leader>fr", "<cmd>lua require('telescope.builtin').registers()<cr>") -- Lists registers
nnoremap("<leader>fh", "<cmd>lua require('telescope.builtin').highlights()<cr>") -- Lists highlights
nnoremap("<leader>fch", "<cmd>lua require('telescope.builtin').command_history()<cr>") -- Lists command_history
nnoremap("<leader>fsh", "<cmd>lua require('telescope.builtin').search_history()<cr>") -- Lists search_history
nnoremap("<leader>fmp", "<cmd>lua require('telescope.builtin').man_pages()<cr>") -- Lists manual pages
nnoremap("<leader>fm", "<cmd>lua require('telescope.builtin').marks()<cr>") -- Lists marks
-- telescope LSP
nnoremap("<leader>lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>") -- Lists LSP references for word under the cursor
nnoremap("<leader>lds", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>") -- Lists LSP document symbols in the current buffer
nnoremap("<leader>lws", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>") -- Lists LSP document symbols in the current workspace
nnoremap("<leader>ldw", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>") -- Dynamically Lists LSP for all workspace symbols
nnoremap("<leader>lca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>") -- Lists any LSP actions for the word under the cursor, that can be triggered with <cr>
-- nnoremap("<leader>lca", "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>") -- Lists any LSP actions for a given range, that can be triggered with <cr>
nnoremap("<leader>ldd", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>") -- Lists LSP diagnostics for the current buffer
nnoremap("<leader>lwd", "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>") -- Lists LSP diagnostics for the current workspace if supported, otherwise searches in all open buffers
nnoremap("<leader>lim", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>") -- Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
nnoremap("<leader>lde", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>") -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
nnoremap("<leader>ltd", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>") -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
-- telescope treesitter
nnoremap("<leader>tre", "<cmd>lua require('telescope.builtin').treesitter()<cr>") -- Lists Function names, variables, from Treesitter!
-- telescope emoji
nnoremap("<leader>emo", "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji', 'gitmoji'} }<cr>") -- telescope emoji doong 😀
-- }}}

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
nnoremap("<leader>pc", "<cmd>PackerCompile<cr>") -- packer compile -- }}}

-- {{{ node
nnoremap("<leader>nod", "<cmd>!tmux split-window 'npm run dev'; read;<cr>") -- svelte run development
nnoremap("<leader>nop", "<cmd>!node build/index.js<cr>") -- node build index js -- }}}

-- {{{ lua
nnoremap("<leader>lua", "<cmd>echo '｡:.ﾟヽ(*´∀`)ﾉﾟ.:｡' | luafile %<cr>") -- source lua -- }}}

-- {{{ formatter
nnoremap("<leader>n", "<cmd>Neoformat<cr>") -- run neoformat -- }}}

-- {{{ searchbox
-- nnoremap("/", "<cmd>lua require('searchbox').match_all({clear_matches = true})<cr>") -- run searchbox -- }}}

-- {{{ nav when insert and command mode
inoremap("<C-h>", "<left>") -- nav left on insert mode
inoremap("<C-j>", "<down>") -- nav down on insert mode
inoremap("<C-k>", "<up>") -- nav up on insert mode
inoremap("<C-l>", "<right>") -- nav right on insert mode -- }}}

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
