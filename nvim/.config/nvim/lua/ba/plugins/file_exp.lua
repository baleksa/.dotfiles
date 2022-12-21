local file_exp = "nvim_tree" -- nvim_tree or netrw

local file_explorers = {
	nvim_tree = function()
		require("ba.plugins.nvim-tree")
	end,
	netrw = function()
		require("ba.plugins.netrw")
	end
}

file_explorers[file_exp]()
