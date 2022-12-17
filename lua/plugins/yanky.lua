vim.cmd([[ packadd yanky ]])

local yk = require("yanky")
--[[ local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping") ]]

yk.setup({
	ring = {
		history_length = 100,
		storage = "shada",
		sync_with_numbered_registers = true,
		cancel_event = "update",
	},
	picker = {
		select = {
			action = nil, -- nil to use default put action
		},
		telescope = {
			mappings = nil, -- nil to use default mappings
			--[[ mappings = {
				default = mapping.put("p"),
				i = {
					["<a-p>"] = mapping.put("p"),
					["<a-k>"] = mapping.put("P"),
					["<a-x>"] = mapping.delete(),
					["<a-r>"] = mapping.set_register(utils.get_default_register()),
				},
				n = {
					p = mapping.put("p"),
					P = mapping.put("P"),
					d = mapping.delete(),
					r = mapping.set_register(utils.get_default_register()),
				},
			}, ]]
			dynamic_preview_title = true,
		},
	},
	system_clipboard = {
		sync_with_ring = true,
	},
	highlight = {
		on_put = true,
		on_yank = true,
		timer = 200,
	},
	preserve_cursor_position = {
		enabled = true,
	},
})

-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker
