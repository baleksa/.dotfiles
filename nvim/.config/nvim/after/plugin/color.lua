local changeColorscheme = function()
	-- local opts = { require("telescope.themes").get_dropdown({}) }
	local opts = {}
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	-- local sorters = require("telescope.sorters")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new(opts, {
			prompt_title = "Pick Colorscheme",
			finder = finders.new_table({
				results = vim.fn.getcompletion('', 'color'),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local picked_colorsceme = selection[1]
					vim.cmd.colorscheme(picked_colorsceme)
				end)
				return true
			end,
		})
		:find()
end
vim.keymap.set("n", "<leader>cc", changeColorscheme, { silent = true })
