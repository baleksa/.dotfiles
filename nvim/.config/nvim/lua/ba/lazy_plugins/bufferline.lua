local M = {
	"akinsho/bufferline.nvim",
	-- tag = "v3.*",
	branch = "dev",
	dependencies = "nvim-tree/nvim-web-devicons",
	cond = function() return vim.g.status_line == "bufferline" end,
}
function M.config()
	require("bufferline").setup({
		options = {
			right_mouse_command = nil,
			indicator = {
				style = "none",
			},
			modified_icon = "[+]",
			diagnostics = "nvim_lsp",
			show_buffer_close_icons = false,
			show_close_icon = false,
			separator_style = { "", "" },
			highlights = {
				buffer_selected = { italic = false },
				numbers_selected = { italic = false },
				diagnostic_selected = { italic = false },
				hint_selected = { italic = false },
				hint_diagnostic_selected = { italic = false },
				info_selected = { italic = false },
				info_diagnostic_selected = { italic = false },
				warning_selected = { italic = false },
				warning_diagnostic_selected = { italic = false },
				pick_selected = { italic = false },
				pick_visible = { italic = false },
				pick = { italic = false },
			},
			offsets = {
				{
					filetype = "NvimTree",
					text = function()
						return "cwd: " .. vim.fn.getcwd()
					end,
					highlight = "Directory",
					separator = "",
					text_align = "left",
				},
			},
		},
	})
end

return M
