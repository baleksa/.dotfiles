require "ba.vim"
require "ba.packer"
require "ba.nvim-lsp"
require "ba.diagnostic"
local plugins = {
	"bufferline",
	"comment",
	"gitsigns",
	"lualine",
	"luasnip",
	"markdown-preview",
	"null-ls",
	"nvim-autopairs",
	"nvim-cmp",
	"nvim-markdown",
	"nvim-tree",
	"telescope",
	"toggleterm",
	"treesitter",
}

for _, plugin in pairs(plugins) do
	require("ba.plugins." .. plugin)
end

require "ba.colorscheme"
require "ba.keymaps"
