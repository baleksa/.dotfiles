local nvim_lsp = require("lspconfig")

local function lsp_highlight_document(client)
	-- Highlight references of object under cursor if server supports that
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, bufopts)
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)

	require("lsp_signature").on_attach()

	lsp_highlight_document(client) -- Add function to highlight
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable the following language servers with the default setup
local servers = {
	-- "clangd",
	"rust_analyzer",
	"pylsp",
	"tsserver",
	"gopls",
	"html",
	"cssls",
	"r_language_server",
	"vimls",
	"bashls",
	"awk_ls",
}

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Setup servers which need custom setup function

-- Kotlin server
nvim_lsp.kotlin_language_server.setup({
	cmd = {
		"/home/baleksa/Repositories/kotlin-language-server/server/build/install/server/bin/kotlin-language-server",
	},
})

nvim_lsp.clangd.setup({
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
	},

	on_attach = on_attach,
	capabilities = capabilities,
})

-- Enable function signature popup helper while in insert mode
require("lsp_signature").setup({
	bind = true,
	handler_opts = {
		border = "rounded",
	},
})

-- Lua server
local sumneko_root_path = os.getenv("GIT_REPOS_DIR") .. "/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
nvim_lsp.sumneko_lua.setup({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
