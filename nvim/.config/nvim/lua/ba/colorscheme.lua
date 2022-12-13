local default_setup = function()
	vim.opt.background = "light"
end
local default_colorscheme = "everforest"

local Colorschemes = {
	oxocarbon = function()
		vim.cmd.colorscheme("oxocarbon")
	end,
	everforest = function()
		vim.g.everforest_background = "soft"
		vim.g.everforest_better_performance = 1
		vim.cmd.colorscheme("everforest")
		require("lualine").setup({
			options = {
				theme = "everforest",
			},
		})
	end,
	onedark = function()
		require("onedark").setup({ -- Set colorcheme options
			style = "deep",
			code_style = {
				comments = "none",
			},
		})
		require("onedark").load()
		require("lualine").setup({ options = { theme = "onedark" } })
		-- Fix color of one rainbow parentheses which wasn't blending nicely with
		-- OneDark colorscheme
		vim.cmd("hi rainbowcol1 guifg=#ffffff")

		-- Set color for filenames of unstaged files in nvim-tree.lua to the current
		-- theme's red color
		local setNvimTreeGitDirtyHighlighColor = function()
			local red = require("onedark.colors").red
			vim.cmd("highlight NvimTreeGitDirty guifg=" .. red)
		end
		setNvimTreeGitDirtyHighlighColor()
		vim.api.nvim_create_autocmd("ColorScheme", { pattern = "onedark", callback = setNvimTreeGitDirtyHighlighColor })
	end,
	monokai = function()
		require("monokai").setup()
		require("lualine").setup({ options = { theme = "powerline" } })
	end,
	moonlight = function()
		require("moonlight").set()
		require("lualine").setup({ options = { theme = "moonlight" } })
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
	end,
}

local colorscheme_names = {}
for k, _ in pairs(Colorschemes) do
	colorscheme_names[#colorscheme_names + 1] = k
end

local ChangeColorscheme = function()
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
vim.keymap.set("n", "<leader>cc", ChangeColorscheme, { silent = true })

local swap_background = function()
---@diagnostic disable-next-line: undefined-field
	if vim.opt.background:get() == "light" then
		vim.opt.background = "dark"
---@diagnostic disable-next-line: undefined-field
	elseif vim.opt.background:get() == "dark" then
		vim.opt.background = "light"
	end
end
vim.keymap.set("n", "<leader>cbg", swap_background, { silent = true })

default_setup()
Colorschemes[default_colorscheme]()
