local M = {
	"noib3/nvim-cokeline",
	requires = "kyazdani42/nvim-web-devicons", -- If you want devicons
	cond = function() return vim.g.status_line == "cokeline" end,
}

function M.config()
	local get_hex = require("cokeline/utils").get_hex

	require("cokeline").setup({
		default_hl = {
			-- fg = function(buffer)
			-- 	return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
			-- end,
			fg = function(buffer)
				return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
			end,
			bg = function(buffer)
				return buffer.is_focused and get_hex("Normal", "bg") or get_hex("TabLine", "bg")
			end,
			-- bg = function(buffer)
			-- 	return buffer.is_focused and get_hex("Normal", "fg") or get_hex("ColorColumn", "bg")
			-- end,
		},

		sidebar = {
			filetype = "neo-tree",
			components = {
				{
					text = function()
						return " cwd: " .. vim.fn.getcwd() .. " "
					end,
					fg = vim.g.terminal_color_3,
					bg = get_hex("Normal", "bg"),
					style = "bold",
					truncation = {
						direction = "left",
					}
				},
			},
		},
		components = {
			{
				text = function(buffer)
					return " " .. buffer.devicon.icon
				end,
				fg = function(buffer)
					return buffer.devicon.color
				end,
			},
			{
				text = function(buffer)
					return buffer.unique_prefix
				end,
				fg = get_hex("Comment", "fg"),
			},
			{
				text = function(buffer)
					return buffer.filename .. " "
				end,
				style = function(buffer)
					return buffer.is_focused and "bold" or nil
				end,
			},
			{
				text = " ",
			},
		},
	})
end

return M