local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- statusline
local fn = vim.fn
local api = vim.api
-- local gps = require("nvim-gps")

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
	local current_mode = api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

local function filepath()
	-- local fpath = fn.fnamemodify(fn.expand("%"), ":~:.:h")
	local fpath = fn.fnamemodify(fn.expand("%"), ":p:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" ",
		added,
		changed,
		removed,
		" ",
		"%#GitSignsAdd# ",
		git_info.head,
		" %#Normal#",
	})
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		update_mode_colors(),
		mode(),
		"%#Normal# ",
		filepath(),
		filename(),
		"%#Normal#",
		lsp(),
		--[[ gps.is_available(),
		gps.get_location(), ]]
		"%=%#StatusLineExtra#",
		filetype(),
		lineinfo(),
	})
end

function Statusline.inactive()
	-- return "%F"
	return "Inactive"
end

function Statusline.short()
	return "%#StatusLineNC#   lemakTree"
end

function Statusline.packer()
	return "%#StatusLineNC# Packer"
end

function Statusline.focusLost()
	return "%#StatusLineNC# Focus Lost Kang %#filename()#"
end

function Statusline.telescopePrompt()
	return "%#StatusLineNC# Telescope Prompt"
end

api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType neo-tree setlocal statusline=%!v:lua.Statusline.short()
  au WinEnter,BufEnter,FileType packer setlocal statusline=%!v:lua.Statusline.packer()
  au WinEnter,BufEnter,FileType TelescopePrompt setlocal statusline=%!v:lua.Statusline.telescopePrompt()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.focusLost()
  augroup END
]],
	false
)

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
