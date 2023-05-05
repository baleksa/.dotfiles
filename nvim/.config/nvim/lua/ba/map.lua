local bind = function(m, l, r, opts)
	vim.keymap.set(m, l, r, opts)
end
local function bindn(l, r, opts)
	bind("n", l, r, opts)
end
local function bindi(l, r, opts)
	bind("i", l, r, opts)
end
local function bindx(l, r, opts)
	bind("x", l, r, opts)
end

bindx("<leader>cs", function()
	-- We need to leave visual selection mode in order to access '< and '>
	-- marks. We can do that by sending <Esc> to nvim. We can do that well
	-- using nvim_feedkeys() and nvim_replace_termcodes() together.
	-- nvim_feedkeys() to send input-keys to vim in blocking mode, and
	-- nvim_replace_termcodes() to replace termcodes.
	-- nvim_input() won't work because it doesn't block, so keys won't get
	-- executed
	-- feedkeys() could be used but its syntax is somewhat uglier
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", false, true, true), "nx", false)
	vim.cmd(":'<,'>w! !cspell stdin")
	vim.cmd.normal("gn")
end, { desc = "Check visual selection with cspell", silent = true })
