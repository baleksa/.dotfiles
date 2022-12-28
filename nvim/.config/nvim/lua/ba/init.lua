local use_lazy = true

if use_lazy then
	require("ba.vim")
	require("ba.lazy")
	require("ba.colorscheme")
	require("ba.autocmd")
else
	require("impatient")
	require("ba.packer")
	require("ba.colorscheme")
	require("ba.nvim-lsp")
	local plugins = {
		"web_devicons",
		"telescope",
		"bufferline",
		"file_exp",
		"gitsigns",
		"lualine",
		"luasnip",
		"markdown-preview",
		"nvim-autopairs",
		"nvim-markdown",
		"toggleterm",
		"treesitter",
		-- "nvim-dap",
	}

	for _, plugin in pairs(plugins) do
		require("ba.plugins." .. plugin)
	end
end
