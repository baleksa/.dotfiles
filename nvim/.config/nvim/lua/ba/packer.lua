-- Bootstrap packer.nvim if it is not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- Run PackerCompile after changing this file
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "packer.lua",
	command = "source <afile> | PackerCompile",
	group = vim.api.nvim_create_augroup("PackerCompile", {}),
})

require("packer").init({ -- Make packer use a popup window
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local use = require("packer").use
require("packer").startup(function()
	use({ "wbthomason/packer.nvim" })

	use({ "lewis6991/impatient.nvim" }) -- Speed up loading Lua modules

	-- tpope's phenomenal plugins
	use({ "tpope/vim-fugitive" }) -- Git commands in nvim
	use({ "tpope/vim-rhubarb" }) -- Fugitive-companion to interact with github
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-repeat" })
	-- use({ "tpope/vim-vinegar" })

	-- Comment plugin written in Lua '
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("ludovicchabant/vim-gutentags") -- Automatic tags management

	-- use({ "ap/vim-buftabline" })
	use({
		"akinsho/bufferline.nvim",
		-- tag = "v3.*",
		branch = "dev",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- use({ "karb94/neoscroll.nvim" })
	-- Don't close vim and don't lose window layout when closing buffers
	use("moll/vim-bbye")

	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- It sets vim.ui.select to telescope. That means for example that
	-- neovim core stuff can fill the telescope picker. Example would
	-- be lua vim.lsp.buf.code_action().
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	-- Fzf algorithm in C too make telescope faster
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({ "stevearc/dressing.nvim" })
	use({ "rcarriga/nvim-notify" })

	use({ "chrisgrieser/nvim-ghengis", requires = "stevearc/dressing.nvim" })

	use({ "akinsho/toggleterm.nvim", branch = "main" }) -- Spawn multiple terminals in nvim with many orientations and send commands to them

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	---
	-- Colorschemes
	---
	use("tanvirtin/monokai.nvim")
	use("shaunsingh/moonlight.nvim")
	use({ "nyoom-engineering/oxocarbon.nvim" })
	use("sainnhe/everforest")
	use("sainnhe/gruvbox-material")
	use("ishan9299/nvim-solarized-lua")
	use({ "rose-pine/neovim", as = "rose-pine" })

	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }) -- Fast and simple statusline written in lua

	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines

	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- Add git related info in the signs columns and popups

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects") -- Additional textobjects for treesitter
	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	})
	use("https://git.sr.ht/~p00f/nvim-ts-rainbow") -- Color nested parentheses diferently for cleaner view
	use("JoosepAlviste/nvim-ts-context-commentstring") -- Comment embedded languages in a right way

	use("windwp/nvim-autopairs") -- auto insert } after {<CR>

	use({
		"folke/twilight.nvim",
		-- Dim inactive portions of code
		config = function()
			require("twilight").setup({ -- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"folke/zen-mode.nvim",
		-- Hides everything except buffer content and enters fullscreen
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- A File Explorer For Neovim Written In Lua
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		-- Don't use this before help and docs of the plugin gets better
		--  Sat Oct  8 09:27:54 AM UTC 2022 It worked.
		tag = "nightly",
	})
	use({ "prichrd/netrw.nvim" })

	-- use("ray-x/lsp_signature.nvim") -- Add function signature help while in insert mode

	use({ -- Priview markdown files in browser with auto scroll sync
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
	})

	use("godlygeek/tabular") -- Vim script for text filtering and alignment

	use("Vimjas/vim-python-pep8-indent") -- Better python indent

	use("andymass/vim-matchup") -- More options to do on matching text and extends vim's %

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	-- Lsp, completion, null-ls, debugging
	use({
		"VonHeikemen/lsp-zero.nvim",
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",

		-- null-ls
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",

		-- Debugging
		"mfussenegger/nvim-dap",
		"jayp0521/mason-nvim-dap.nvim",
	})
	-- Aditional lsp plugins
	use("https://git.sr.ht/~p00f/clangd_extensions.nvim")
	use("mfussenegger/nvim-jdtls")

	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")
	-- use("mfussenegger/nvim-dap-python")

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	use("DaikyXendo/nvim-material-icon")
end)
