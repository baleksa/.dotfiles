---
-- lsp-zero
--
local lsp = require("lsp-zero")
lsp.preset("manual-setup")
lsp.set_preferences({
	set_lsp_keymaps = false,
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

	bind("n", "<leader>f", vim.lsp.buf.format)
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
	"sumneko_lua",
	"vimls",
})

lsp.nvim_workspace() -- Add neovim and plugins lua files to sumneko-lua
lsp.setup_servers({
	"bashls",
	"gopls",
	"kotlin_language_server",
	"pylsp",
	"r_language_server",
	"rust_analyzer",
	"sumneko_lua",
	"vimls",
	-- "clangd",
})
-- Add additional special conf to some servers
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
---
-- cmp
---
local cmp = require("cmp")
lsp.setup_nvim_cmp({
	-- completion = { completeopt = "menu, menuone, noselect" },
	sources = { name = "nvim_lua" },
})
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
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
lsp.setup()
---
-- null-ls
---
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- Formatting
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.shellharden,
		-- Diagnostics
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.shellcheck,
		-- Code actions
		null_ls.builtins.code_actions.shellcheck,
	},
})
require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})
---
-- nvim-dap
---
local mason_dap = require("mason-nvim-dap")
mason_dap.setup({
	ensure_installed = {
		"bash",
		"codelldb",
		"delve",
		"firefox",
		"javadbg",
		"kotlin",
		"python",
	},
	automatic_setup = true,
})
mason_dap.setup_handlers({})
