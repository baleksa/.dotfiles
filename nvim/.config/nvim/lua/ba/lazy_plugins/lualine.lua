local M = { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons", lazy = true } }

function M.config()
	require("lualine").setup({
		options = {
			-- theme = 'onedark',
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
	})
end
return M
