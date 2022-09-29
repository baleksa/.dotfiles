local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]])

require("packer").init({ -- Make packer use a popup window
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Uncomment this to fix fatal: Not possible to fast-forward, aborting :PackerUpdate error
-- require('packer').init({git = { subcommands = { update = 'pull --progress --rebase=true'}}})

local use = require("packer").use
require("packer").startup(function()
	-- INSTALLED PACKAGES

	use("wbthomason/packer.nvim") -- Package manager

	-- Tpope's phenomenal plugins
	use("tpope/vim-fugitive") -- Git commands in nvim
	use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
	use("tpope/vim-surround")
	use("tpope/vim-repeat")

	-- Comment plugin written in Lua '
	use({
		"numToStr/Comment.nvim",
		-- commit = "0aaea32f27315e2a99ba4c12ab9def5cbb4842e4",
		config = function()
			require("Comment").setup()
		end,
	})

	use("ludovicchabant/vim-gutentags") -- Automatic tags management

	use({ "akinsho/bufferline.nvim", branch = "main", requires = "kyazdani42/nvim-web-devicons" }) -- Powerful buffer plugin which shows all buffers in topline

	use("moll/vim-bbye") -- Don't close vim and dont lose window layout when closing buffers

	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- It sets vim.ui.select to telescope. That means for example that
	-- neovim core stuff can fill the telescope picker. Example would
	-- be lua vim.lsp.buf.code_action().
	use({ "nvim-telescope/telescope-ui-select.nvim" })

	-- Fzf algorithm in C too make telescope faster
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use({ "stevearc/dressing.nvim" })

	use({ "akinsho/toggleterm.nvim", branch = "main" }) -- Spawn multiple terminals in nvim with many orientations and send commands to them

	use("navarasu/onedark.nvim") -- Onedark theme with treesitter support
	use("tanvirtin/monokai.nvim") -- Monokai theme with treesitter support
	use("shaunsingh/moonlight.nvim") -- Moonlight theme with treesitter support

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
	use("p00f/nvim-ts-rainbow") -- Color nested parentheses diferently for cleaner view
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

	use({
		"kyazdani42/nvim-tree.lua", -- A File Explorer For Neovim Written In Lua
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		-- tag = 'nightly'
	})

	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client

	use("mfussenegger/nvim-dap") -- Debug adapter Protocol client implementation
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")
	use("mfussenegger/nvim-dap-python")

	use("ray-x/lsp_signature.nvim") -- Add function signature help while in insert mode

	-- Completion plugin and its sources
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp nvim-lsp completion source
	use("hrsh7th/cmp-path") -- nvim-cmp filesystem paths completion source
	use("hrsh7th/cmp-buffer") -- Words from current buffer completion source
	use("hrsh7th/cmp-cmdline") -- Vim's command mode completion source
	use("hrsh7th/cmp-nvim-lua") -- Neovim Lua API completion source
	use("saadparwaiz1/cmp_luasnip") -- nvim-cmp luasnip completion source
	-- use 'uga-rosa/cmp-dictionary' -- nvim-cmp dictionaries source

	use({ -- Make non-lsp sources able to hook into its LSP client
		'jose-elias-alvarez/null-ls.nvim',
		commit = '76d0573fc159839a9c4e62a0ac4f1046845cdd50',
		requires = { "nvim-lua/plenary.nvim" },
	})

	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use("rafamadriz/friendly-snippets") -- vscode snippets

	use({ -- Priview markdown files in browser with auto scroll sync
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
	})

	use("godlygeek/tabular") -- Vim script for text filtering and alignment

	use("Vimjas/vim-python-pep8-indent") -- Better python indent

	use("ixru/nvim-markdown") -- Markdown highlighting and some other features

	use("andymass/vim-matchup") -- More options to do on matching text and extends vim's %

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Extensions for the built-in Language Server Protocol support in
	-- Neovim (>= 0.6.0) for eclipse.jdt.ls.
	use("mfussenegger/nvim-jdtls")
end)
