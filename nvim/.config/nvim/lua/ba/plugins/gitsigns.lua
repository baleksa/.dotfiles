require("gitsigns").setup({
	-- signs = {
	--   add = { hl = 'GitGutterAdd', text = '+' },
	--   change = { hl = 'GitGutterChange', text = '~' },
	--   delete = { hl = 'GitGutterDelete', text = '_' },
	--   topdelete = { hl = 'GitGutterDelete', text = '‾' },
	--   changedelete = { hl = 'GitGutterChange', text = '~' },
	-- },
	signs = {
		add = { hl = "GitSignsAdd", text = "▎" },
		change = { hl = "GitSignsChange", text = "▎" },
		delete = { hl = "GitSignsDelete", text = "契" },
		topdelete = { hl = "GitSignsDelete", text = "契" },
		changedelete = { hl = "GitSignsChange", text = "▎" },
	},
})
