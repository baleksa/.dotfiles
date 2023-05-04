return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			vim.lsp.set_log_level("ERROR")

			require("lsp-zero.settings").preset({
				float_border = "rounded",
			})

			require("lsp-zero.server").set_sign_icons({
				error = "",
				-- error = "✖", -- this can only be used in the git_status source
				warn = "󰔷",
				-- warn = "▲",
				hint = "",
				-- hint = "⚑",
				-- info = "",
				info = "",
			})
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
			},
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

			require("luasnip.loaders.from_vscode").lazy_load()

			require("lsp-zero.cmp").extend({
				set_sources = "recommended",
				set_extra_mappings = true,
				use_luasnip = true,
			})

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			-- local cmp_action = require("lsp-zero.cmp").action()

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
					-- { name = "nvim_lua" },
					-- { name = "nvim_lsp_signature_help" },
					{ name = "crates" },
				},
				sorting = {
					comparators = {
						require("clangd_extensions.cmp_scores"),
					},
				},
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline({}),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
				}),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
			},
			"folke/neodev.nvim", -- for better Lua dev experience
			{
				"smjonas/inc-rename.nvim",
				opts = { input_buffer_type = "dressing" },
			},
			{
				"simrat39/symbols-outline.nvim",
				config = true,
			},
		},
		config = function()
			-- This is where all the LSP shenanigans will live

			local lsp = require("lsp-zero")
			local lspconfig = require("lspconfig")

			lsp.ensure_installed({
				"gopls",
				"kotlin_language_server",
				"vimls",
				"html",
				"cssls",
				"jsonls",
				"tsserver",
				"standardrb",
				"lua_ls",
				"solargraph",
				"bashls",
				"clangd",
				-- "jdtls",
				"pylsp",
				"rust_analyzer",
			})

			local common_on_attach = function(client, bufnr)
				local bufopts = { silent = true, buffer = bufnr }
				local bind = function(m, lhs, rhs, opts)
					opts = opts or {}
					vim.keymap.set(m, lhs, rhs, vim.tbl_extend("force", bufopts, opts))
				end

				if client.config.root_dir then
					vim.api.nvim_set_current_dir(client.config.root_dir)
				end
				if client.server_capabilities.documentSymbolProvider and client.name ~= "standardrb" then
					require("nvim-navic").attach(client, bufnr)
				end

				bind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
				-- bind("i", "<C-h>", lspbuf.signature_help)
				--
				bind("n", "<leader>rn", function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end, { expr = true })

				bind("n", "<leader>d", vim.diagnostic.open_float)
				bind("n", "[e", function()
					vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end)
				bind("n", "]e", function()
					vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
				end)

				bind("n", "<leader>o", "<cmd>SymbolsOutline<CR>")
			end

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({
					buffer = bufnr,
					omit = { "gl" },
					preserve_mappings = false,
				})
				common_on_attach(client, bufnr)
			end)

			lsp.format_mapping("gq", {
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = {
						"ruby",
						"lua",
						"html",
						"sh",
						"bash",
						"zsh",
						"markdown",
						"vue",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"markdown.mdx",
						"graphql",
						"handlebars",
					},
					rust_analyzer = { "rust" },
					pylsp = { "python" },
				},
			})

			require("neodev").setup({})
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						format = {
							enable = false,
						},
					},
				},
			})

			lspconfig.solargraph.setup({
				filetypes = {
					"ruby",
					"eruby",
				},
				init_options = {
					formatting = false,
				},
			})

			lspconfig.pylsp.setup({
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
								-- executable = vim.fn.stdpath("data") .. "/mason/packages/python-lsp-server/venv/bin/ruff",
								lineLength = 80,
								extendSelect = {
									"W",
									"C",
									"I",
									"D",
								},
							},
						},
					},
				},
			})

			lspconfig.bashls.setup({
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

			-- lspconfig.clangd.setup(vim.tbl_deep_extend(
			-- 	"error",
			-- 	{},
			-- 	require("clangd_extensions").prepare({
			-- 		server = {
			-- 			cmd = {
			-- 				vim.fn.stdpath("data") .. "/mason/bin/clangd",
			-- 				"--background-index",
			-- 				"--suggest-missing-includes",
			-- 				"--clang-tidy",
			-- 				"--header-insertion=iwyu",
			-- 			},
			-- 		},
			-- 	})
			-- ))

			lspconfig.prosemd_lsp.setup({
				on_attach = function(client, _)
					if not vim.list_contains(vim.opt_local.spelllang:get(), "en") then
						client:stop()
					end
				end,
			})

			lsp.skip_server_setup({ "clangd", "rust-analyzer", "prosemd_lsp" })

			lsp.setup()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
			local codelldb_path = extension_path .. "/adapter/codelldb"
			local liblldb_path = extension_path .. "/lldb/lib/liblldb.so" -- MacOS: This may be .dylib

			local rust_tools = require("rust-tools")
			rust_tools.setup({
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>ha", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
					end,
				},
				-- hover_actions = {
				-- 	auto_focus = true,
				-- },
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		end,
	},
	{
		url = "https://git.sr.ht/~p00f/clangd_extensions.nvim",
		-- dependencies = {
		-- 	"VonHeikemen/lsp-zero.nvim",
		-- },
		config = function()
			-- Fix for
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
			require("clangd_extensions").setup({
				server = {
					capabilities = vim.tbl_deep_extend(
						"force",
						vim.lsp.protocol.make_client_capabilities(),
						require("cmp_nvim_lsp").default_capabilities(),
						{
							offsetEncoding = { "utf-16", "utf-8", "utf-32" },
						}
					),
				},
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			handler_opts = {
				border = "rounded",
			},
			floating_window = false,
			floating_window_above_cur_line = true,
			hint_prefix = "➡️ ",
			padding = " ",
			zindex = 40,
			toggle_key = "<C-h>",
		},
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		opts = {
			highlight = true,
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			attach_navic = false,
		},
	},
	{
		"saecki/crates.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- version = "v0.3.0",
		opts = {
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		},
		event = "BufRead Cargo.toml",
	},
	{
		"RubixDev/mason-update-all",
		config = function()
			require("mason-update-all").setup()
			vim.api.nvim_create_autocmd("User", {
				pattern = "MasonUpdateAllComplete",
				callback = function()
					print("mason-update-all has finished")
				end,
			})
		end,
	},
}
