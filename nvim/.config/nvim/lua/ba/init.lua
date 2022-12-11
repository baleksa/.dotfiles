require("ba.vim")
require("ba.packer")
require("ba.keymaps")
require("ba.nvim-lsp")
require("ba.diagnostic")
require("ba.colorscheme")
require("ba.autocmd")
require("ba.netrw")

local plugins = {
	"telescope",
	-- "buffeline",
	"nvim-tree",
	-- "netrw-nvim",
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
	"nvim-dap",
}

for _, plugin in pairs(plugins) do
	require("ba.plugins." .. plugin)
end
