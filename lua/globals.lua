local ok, plenary_reload = pcall(require("plenary.reload"))

if not ok then
	reloader = require
else
	reloader = plenary_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
