return {
	{
		"kyazdani42/nvim-web-devicons",
		dependencies = { "DaikyXendo/nvim-material-icon" },
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-icon").get_icons(),
			})
		end,
	},
	-- tpope's phenomenal plugins
	{ "tpope/vim-fugitive" }, -- Git commands in nvim
	{ "tpope/vim-rhubarb" }, -- Fugitive-companion to interact with github
	{ "tpope/vim-repeat" },
	{ "kylechui/nvim-surround", version = "*", config = true },
	{ "jcdickinson/wpm.nvim", config = true },
	-- Comment plugin written in Lua '
	{ "numToStr/Comment.nvim", config = true },
	-- Automatic tags management,
	{ "ludovicchabant/vim-gutentags" },
	-- Don't close vim and don't lose window layout when closing buffers
	{ "moll/vim-bbye" },

	-- UI to select things (files, grep results, open buffers...)
	-- It sets vim.ui.select to telescope. That means for example that
	-- neovim core stuff can fill the telescope picker. Example would
	-- be lua vim.lsp.buf.code_action().
	{ "nvim-telescope/telescope-ui-select.nvim" },
	-- Fzf algorithm in C too make telescope faster
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	{ "stevearc/dressing.nvim" },
	{ "chrisgrieser/nvim-ghengis", dependencies = "stevearc/dressing.nvim" },

	{
		"akinsho/toggleterm.nvim",
		branch = "main",
		opts = {
			open_mapping = [[<c-\>]],
			autochdir = true,
		},
	}, -- Spawn multiple terminals in nvim with many orientations and send commands to them

	{
		"norcalli/nvim-colorizer.lua",
		config = true,
	},

	{ "lukas-reineke/indent-blankline.nvim" },

	{
		"folke/twilight.nvim",
		-- Dim inactive portions of code
		config = true,
	},

	{
		"folke/zen-mode.nvim",
		-- Hides everything except buffer content and enters fullscreen
		config = true,
	},
	{ "prichrd/netrw.nvim" },
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({ theme = "light" })
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
		ft = { "markdown" },
	},

	{ "godlygeek/tabular" }, -- Vim script for text filtering and alignment,

	{ "andymass/vim-matchup" }, -- More options to do on matching text and extends vim's %,

	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup()
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"j-hui/fidget.nvim",
		config = true,
	},
	-- { "baleksa/simplebufline.nvim", dev = true },
	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({
				hide = {
					-- 	cursorline = true,
					only_win = true,
				},
				window = {
					margin = {
						vertical = 0,
					},
				},
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"lir",
					"fugitive",
				},
			})
		end,
	},
	{ "shortcuts/no-neck-pain.nvim", opts = { buffers = {} } },
	{ "RaafatTurki/hex.nvim", config = true },
	{ "vim-scripts/Decho" },
	{ "m4xshen/smartcolumn.nvim", opts = { scope = "window" } },
}
