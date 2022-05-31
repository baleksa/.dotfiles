require("onedark").setup({ -- Set colorcheme options
	style = "deep",
	code_style = {
		comments = "none",
	},
})

local setOneDark = function()
	require("onedark").load()
	require("lualine").setup({ options = { theme = "onedark" } })
end

local setMonokai = function()
	require("monokai").setup()
	require("lualine").setup({ options = { theme = "powerline" } })
end

local setMoonlight = function()
	require("moonlight").set()
	require("lualine").setup({ options = { theme = "moonlight" } })
end

local theme_index = 1
local setThemeFunctions = { setOneDark, setMoonlight, setMonokai }
setThemeFunctions[theme_index]()
ChangeTheme = function()
	theme_index = theme_index + 1
	if theme_index > #setThemeFunctions then
		theme_index = 1
	end
	setThemeFunctions[theme_index]()
end
vim.api.nvim_set_keymap("n", "<leader>tc", "<CMD>lua ChangeTheme()<CR>", { noremap = true, silent = true })

-- Fix color of one rainbow parentheses which wasn't blending nicely with
-- OneDark colorscheme
vim.cmd("hi rainbowcol1 guifg=#ffffff")

vim.cmd("highlight WinSeparator guibg=None") -- Crisp whiteline between windows

-- Set color for filenames of unstaged files in nvim-tree.lua to the current
-- theme's red color
local setNvimTreeGitDirtyHighlighColor = function()
	local red = require("onedark.colors").red
	vim.cmd("highlight NvimTreeGitDirty guifg=" .. red)
end
setNvimTreeGitDirtyHighlighColor()
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "onedark", callback = setNvimTreeGitDirtyHighlighColor })
