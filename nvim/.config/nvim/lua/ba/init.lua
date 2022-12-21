require("impatient")
require("ba.colorscheme")
require("ba.vim")
require("ba.keymaps")
require("ba.packer")
require("ba.nvim-lsp")
-- require("ba.diagnostic")
require("ba.autocmd")

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
