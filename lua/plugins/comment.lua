local api = require("Comment.api")
local map = vim.keymap.set

require("Comment").setup({
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = nil,
	---LHS of toggle mappings in NORMAL mode
	toggler = {
		---Line-comment toggle keymap
		line = "gcc",
		---Block-comment toggle keymap
		block = "gbc",
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		---Line-comment keymap
		line = "gc",
		---Block-comment keymap
		block = "gb",
	},
	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = "gcO",
		---Add comment on the line below
		below = "gco",
		---Add comment at the end of line
		eol = "gcA",
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,
	--[[ post_hook = function(ctx)
		local r = unpack(vim.api.nvim_win_get_cursor(0))
		local rcnt = vim.api.nvim_buf_line_count(0)
		if rcnt > r then
			vim.api.nvim_win_set_cursor(0, { r + 1, 0 })
		end
	end, ]]
})

--[[ map("n", "g>", api.call("comment.linewise", "g@"), { expr = true, desc = "Comment region linewise" })
map("n", "g>c", api.call("comment.linewise.current", "g@$"), { expr = true, desc = "Comment current line" })
map("n", "g>b", api.call("comment.blockwise.current", "g@$"), { expr = true, desc = "Comment current block" })

map("n", "g<", api.call("uncomment.linewise", "g@"), { expr = true, desc = "Uncomment region linewise" })
map("n", "g<c", api.call("uncomment.linewise.current", "g@$"), { expr = true, desc = "Uncomment current line" })
map("n", "g<b", api.call("uncomment.blockwise.current", "g@$"), { expr = true, desc = "Uncomment current block" }) ]]

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

map("x", "g>", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Comment region linewise (visual)" })

map("x", "g<", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.locked("uncomment.linewise")(vim.fn.visualmode())
end, { desc = "Uncomment region linewise (visual)" })

function _G.__toggle_contextual(vmode)
	local cfg = A.get_config()
	local range = U.get_region(vmode)
	local same_line = range.srow == range.erow

	local ctx = {
		cmode = U.cmode.toggle,
		range = range,
		cmotion = U.cmotion[vmode] or U.cmotion.line,
		ctype = same_line and U.ctype.line or U.ctype.block,
	}

	local lcs, rcs = U.parse_cstr(cfg, ctx)
	local lines = U.get_lines(range)

	local params = {
		range = range,
		lines = lines,
		cfg = cfg,
		cmode = ctx.cmode,
		lcs = lcs,
		rcs = rcs,
	}

	if same_line then
		Op.linewise(params)
	else
		Op.blockwise(params)
	end
end

map("n", "<Leader>c", "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@")
map("x", "<Leader>c", "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@")
