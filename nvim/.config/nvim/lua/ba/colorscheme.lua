local default_colorscheme = "everforest_hard"
local current_colorscheme = "everforest_hard"

local default_setup = function()
	vim.opt.background = "light"
end
local Colorschemes = {
	oxocarbon = function()
		vim.cmd.colorscheme("oxocarbon")
		current_colorscheme = "oxocarbon"
	end,
	everforest_hard = function()
		vim.g.everforest_background = "hard"
		vim.g.everforest_better_performance = 1
		vim.g.everforest_disable_italic_comment = 1
		vim.g.everforest_enable_italic = 0
		vim.cmd.colorscheme("everforest")
		require("lualine").setup({
			options = {
				theme = "everforest",
			},
		})
		current_colorscheme = "everforest_hard"
	end,
	rose_pine = function()
		vim.cmd.colorscheme("rose-pine")
		current_colorscheme = "rose_pine"
	end,
	rose_pine_moon = function()
		require("rose-pine").setup({ dark_variant = "moon" })
		vim.cmd.colorscheme("rose-pine")
		current_colorscheme = "rose_pine_moon"
	end,
	monokai = function()
		require("monokai").setup()
		require("lualine").setup({ options = { theme = "powerline" } })
		current_colorscheme = "monokai"
	end,
	moonlight = function()
		require("moonlight").set()
		require("lualine").setup({ options = { theme = "moonlight" } })
		current_colorscheme = "moonlight"
	end,
	gruvbox_original = function()
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_foreground = "original"
		vim.cmd.colorscheme("gruvbox-material")
		require("lualine").setup({
			options = {
				theme = "gruvbox-material",
			},
		})
		current_colorscheme = "gruvbox_original"
	end,
	gruvbox_mix = function()
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_foreground = "mix"
		vim.cmd.colorscheme("gruvbox-material")
		require("lualine").setup({
			options = {
				theme = "gruvbox-material",
			},
		})
		current_colorscheme = "gruvbox_mix"
	end,
	gruvbox_material = function()
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_foreground = "material"
		vim.cmd.colorscheme("gruvbox-material")
		require("lualine").setup({
			options = {
				theme = "gruvbox-material",
			},
		})
		current_colorscheme = "gruvbox_material"
	end,
}

local colorscheme_names = {}
for k, _ in pairs(Colorschemes) do
	colorscheme_names[#colorscheme_names + 1] = k
end

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
				results = colorscheme_names,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					-- print(selection)
					-- vim.api.nvim_put({ selection[1] }, "", false, true)
					Colorschemes[selection[1]]()
				end)
				return true
			end,
		})
		:find()
end
vim.keymap.set("n", "<leader>cc", changeColorscheme, { silent = true })

local swap_background = function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.background:get() == "light" then
		vim.opt.background = "dark"
		---@diagnostic disable-next-line: undefined-field
	elseif vim.opt.background:get() == "dark" then
		vim.opt.background = "light"
	end
	Colorschemes[current_colorscheme]()
end
vim.keymap.set("n", "<leader>cbg", swap_background, { silent = true })

default_setup()
Colorschemes[default_colorscheme]()
