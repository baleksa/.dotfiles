require("ba.vim")
require("ba.packer")
require("ba.nvim-lsp")
require("ba.diagnostic")
require("ba.colorscheme")
require("ba.keymaps")

local plugins = {
	"telescope",
	"bufferline",
	"nvim-tree",
	"comment",
	"gitsigns",
	"lualine",
	"luasnip",
	"markdown-preview",
	"null-ls",
	"nvim-cmp",
	"nvim-autopairs",
	"nvim-markdown",
	"toggleterm",
	"treesitter",
}

for _, plugin in pairs(plugins) do
	require("ba.plugins." .. plugin)
end

-- require'nvim-tree'.setup {}
