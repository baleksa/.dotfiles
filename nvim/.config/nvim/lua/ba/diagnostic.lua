local signs = { Error = "", Warn = "", Hint = "", Info = "" } -- Change diagnostics signs
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = false, -- Don't print diagnostics in virtual text because it's not pretty and it takes a lot of space
	update_in_insert = true,
	signs = {
		active = signs,
	},
	severity_sort = true,
	float = {
		focusable = false,
		-- style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		-- prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded", -- Chasing rounded borders
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded", -- For that eyecandy joy
})

-- Show diagnostics automatically on cursor hover
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
