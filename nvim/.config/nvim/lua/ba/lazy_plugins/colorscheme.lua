return {
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			undercurl = true,
			underline = true,
			bold = true,
			italic = false,
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
	},
	{
		"tanvirtin/monokai.nvim",
		lazy = true,
		-- priority = 1000,
		opts = {
			italics = false,
		},
	},
	{
		"shaunsingh/moonlight.nvim",
		-- lazy = false,
		-- priority = 1000,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		build = "./install.sh",
		-- lazy = false,
		-- priority = 1000,
	},
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_better_performance = 1
			vim.g.everforest_disable_italic_comment = 1
			vim.g.everforest_enable_italic = 0
			vim.opt.background = "light"
			vim.cmd.colorscheme("everforest")
			require("lualine").setup({
				options = {
					theme = "everforest",
				},
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		cond = false,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- lazy = false,
		-- priority = 1000,
		opts = {
			disable_italics = true,
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			theme = "tokyonight",
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
			},
		},
		lualine_bold = true,
	},
}
