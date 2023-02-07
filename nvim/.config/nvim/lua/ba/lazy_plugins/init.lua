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
	---
	-- Colorschemes
	---
	{ "tanvirtin/monokai.nvim" },
	{ "shaunsingh/moonlight.nvim" },
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "sainnhe/everforest" },
	{ "sainnhe/gruvbox-material" },
	{ "ishan9299/nvim-solarized-lua" },
	{ "rose-pine/neovim", name = "rose-pine" },

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
	-- Packer
	-- {
	-- 	"folke/noice.nvim",
	-- 	config = {
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true,
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			bottom_search = true, -- use a classic bottom cmdline for search
	-- 			command_palette = true, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },

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

	{ "lukas-reineke/indent-blankline.nvim" }, -- Add indentation guides even on blank lines

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Additional textobjects for treesitter,
	{
		"lewis6991/spellsitter.nvim",
		config = true,
	},
	{ url = "https://git.sr.ht/~p00f/nvim-ts-rainbow" }, -- Color nested parentheses diferently for a cleaner view,
	{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- Comment embedded languages in a right way,

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

	-- use("ray-x/lsp_signature.nvim") -- Add function signature help while in insert mode

	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	build = "cd app && npm install",
	-- 	config = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- },
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

	{ "Vimjas/vim-python-pep8-indent" }, -- Better python indent,

	{ "andymass/vim-matchup" }, -- More options to do on matching text and extends vim's %,

	{
		"folke/which-key.nvim",
		config = true,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "nvim-telescope/telescope-dap.nvim" },
	-- use("mfussenegger/nvim-dap-python")

	{
		"j-hui/fidget.nvim",
		config = true,
	},
	-- { "baleksa/simplebufline.nvim", dev = true },
	{
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({
				-- hide = {
				-- 	cursorline = true,
				-- },
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
	{ "shortcuts/no-neck-pain.nvim" },
	{ "RaafatTurki/hex.nvim", config = true },
}
