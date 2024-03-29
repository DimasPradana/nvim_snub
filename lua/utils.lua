-- Better Keymaps
local M = {}

-- :help map-modes
function M.map(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true })
end

function M.noremap(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

function M.exprnoremap(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true, expr = true })
end

function M.custom_cwd()
	if vim.loop.cwd() == vim.loop.os_homedir() then
		return vim.fn.expand("%:p:h")
	end
	return vim.loop.cwd()
end

--[[ function M.eval()
	-- cara cek api pakai :lua = nama api, misal vim.api.nvim_eval_statusline("%f", {}).str
	local file_path = vim.api.nvim_eval_statusline("%f", {}).str
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "⦿" or "" -- jika ada modifikasi munculkan icon "⦿", jika tidak string kosong

	file_path = file_path:gsub("/", " ➤  ")

	return string.format("%s %s", file_path, modified)
end ]]

-- stylua: ignore start
function M.nmap(lhs, rhs) M.map('n', lhs, rhs) end

function M.nnoremap(lhs, rhs) M.noremap('n', lhs, rhs) end

function M.vnoremap(lhs, rhs) M.noremap('v', lhs, rhs) end

function M.xnoremap(lhs, rhs) M.noremap('x', lhs, rhs) end

function M.inoremap(lhs, rhs) M.noremap('i', lhs, rhs) end

function M.tnoremap(lhs, rhs) M.noremap('t', lhs, rhs) end

function M.cnoremap(lhs, rhs) M.noremap('c', lhs, rhs) end

function M.exprinoremap(lhs, rhs) M.exprnoremap('i', lhs, rhs) end

function M.exprnnoremap(lhs, rhs) M.exprnoremap('n', lhs, rhs) end

return M
-- stylua: ignore end

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
