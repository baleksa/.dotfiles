---
-- lsp-zero
--
local lsp = require("lsp-zero")

local common_on_attach = function (_, bufnr)
	local bufopts = { silent = true, buffer = bufnr }
	local bind = function (m, lhs, rhs)
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

lsp.preset("recommended")
lsp.on_attach(common_on_attach)

-- Add additional special conf to some servers
lsp.configure(
	"clangd",
	vim.tbl_deep_extend(
		"error",
		{ force_setup = true },
		require("clangd_extensions").prepare({
			server = {
				cmd = {
					"clangd",
					"--background-index",
					"--suggest-missing-includes",
					"--clang-tidy",
					"--header-insertion=iwyu",
				},
			},
		})
	)
)

lsp.nvim_workspace()
lsp.setup()
