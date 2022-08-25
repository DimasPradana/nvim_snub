local ok, plenary_reload = pcall(require("plenary.reload"))

if not ok then
	Reloader = require
else
	Reloader = plenary_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
