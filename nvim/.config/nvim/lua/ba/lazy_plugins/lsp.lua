local M = {
	-- Lsp, completion, null-ls, debugging
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"RubixDev/mason-update-all",

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

		-- Aditional lsp plugins
		{ url = "https://git.sr.ht/~p00f/clangd_extensions.nvim" },
		{ "mfussenegger/nvim-jdtls" },
		"folke/neodev.nvim",
		"simrat39/rust-tools.nvim",
	},
}

function M.config()
	---
	-- lsp-zero
	---
	local lsp = require("lsp-zero")
	lsp.preset("manual-setup")
	lsp.set_preferences({
		set_lsp_keymaps = false,
		sign_icons = {
			-- error = "",
			error = "",
			-- error = "✖", -- this can only be used in the git_status source
			-- error = "",
			warn = "▲",
			hint = "",
			-- hint = "⚑",
			info = "",
		},
	})

	local common_on_attach = function(_, bufnr)
		local bufopts = { silent = true, buffer = bufnr }
		local bind = function(m, lhs, rhs)
			vim.keymap.set(m, lhs, rhs, bufopts)
		end
		local lspbuf = vim.lsp.buf

		bind("n", "K", lspbuf.hover)
		bind("n", "gd", lspbuf.definition)
		bind("n", "gD", lspbuf.declaration)
		bind("n", "gi", lspbuf.implementation)
		bind("n", "go", lspbuf.type_definition)
		bind("n", "gr", lspbuf.references)
		bind("i", "<C-h>", lspbuf.signature_help)
		bind("n", "<leader>rn", lspbuf.rename)
		bind("n", "<leader>ca", lspbuf.code_action)

		bind("n", "<leader>d", vim.diagnostic.open_float)
		bind("n", "[d", vim.diagnostic.goto_prev)
		bind("n", "]d", vim.diagnostic.goto_next)
		bind("n", "gl", vim.diagnostic.setloclist)

		bind("n", "<leader>f", lspbuf.format)
	end
	lsp.on_attach(common_on_attach)

	lsp.ensure_installed({
		"bashls",
		"clangd",
		"gopls",
		"jdtls",
		"kotlin_language_server",
		"pylsp",
		"r_language_server",
		"rust_analyzer",
		"lua_ls",
		"vimls",
	})
	-- Add neovim and plugins lua files to sumneko-lua
	-- lsp.nvim_workspace({
	-- 	-- library = vim.api.nvim_get_runtime_file("", true),
	-- })
	require("neodev").setup({
		library = { plugins = { "nvim-dap-ui" }, types = true },
	})

	lsp.setup_servers({
		"gopls",
		"kotlin_language_server",
		-- "pylsp",
		"r_language_server",
		-- "rust_analyzer",
		"lua_ls",
		"vimls",
	})
	-- Add additional special conf to some servers
	lsp.configure("pylsp", {
		settings = {
			pylsp = {
				plugins = {
					black = {
						enabled = true,
						line_length = 80,
					},
					rope_autoimport = { enabled = true },
					ruff = {
						enabled = true,
						executable = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv/bin/ruff",
						lineLength = 80,
						select = {
							"F",
							"E",
							"W",
							"C",
							"I",
							-- "D",
						},
					},
				},
			},
		},
	})
	lsp.configure("bashls", {
		filetypes = {
			"sh",
			"bash",
			"zsh",
			".bash_login",
			".bash_logout",
			".bash_profile",
			".bashrc",
			".profile",
			".zshenv",
			".zlogin",
			".zlogout",
			".zprofile",
			".zshrc",
			"APKBUILD",
			"PKGBUILD",
			"eclass",
			"ebuild",
			"bazelrc",
			".bash_aliases",
		},
	})
	lsp.configure(
		"clangd",
		vim.tbl_deep_extend(
			"error",
			{},
			require("clangd_extensions").prepare({
				server = {
					cmd = {
						vim.fn.stdpath("data") .. "/mason/bin/clangd",
						"--background-index",
						"--suggest-missing-includes",
						"--clang-tidy",
						"--header-insertion=iwyu",
					},
				},
			})
		)
	)
	local rust_analyzer_opts = lsp.build_options("rust_analyzer", {})
	lsp.setup()
	---
	-- rust-tools
	---
	local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
	local codelldb_path = extension_path .. "/adapter/codelldb"
	local liblldb_path = extension_path .. "/lldb/lib/liblldb.so" -- MacOS: This may be .dylib
	require("rust-tools").setup({
		server = rust_analyzer_opts,
		-- hover_actions = {
		-- 	auto_focus = true,
		-- },
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
	---
	-- cmp
	---
	local cmp = require("cmp")
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline({
			["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
		}),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	})
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
	---
	-- null-ls
	---
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			-- Formatting
			null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.formatting.black,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.shellharden,
			-- Diagnostics
			null_ls.builtins.diagnostics.shellcheck,
			-- Code actions
			null_ls.builtins.code_actions.shellcheck,
			null_ls.builtins.code_actions.gitsigns,
		},
	})

	require("mason-null-ls").setup({
		ensure_installed = nil,
		automatic_installation = false,
		automatic_setup = false,
	})

	-- Fix https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
	local old_notify = vim.notify
	vim.notify = function(msg, ...)
		if msg:match("warning: multiple different client offset_encodings") then
			return
		end

		old_notify(msg, ...)
	end

	---
	-- Misc
	---
	-- Setup command to update all installed Mason packages
	require("mason-update-all").setup()
	vim.api.nvim_create_autocmd("User", {
		pattern = "MasonUpdateAllComplete",
		callback = function()
			print("mason-update-all has finished")
		end,
	})
end

return M
