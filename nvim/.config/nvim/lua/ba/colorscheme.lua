require("onedark").setup({ -- Set colorcheme options
	style = "deep",
	toggle_style_key = "<leader>tc",
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
vim.api.nvim_set_keymap("n", "<leader>ct", "<CMD>lua ChangeTheme()<CR>", { noremap = true, silent = true })

vim.cmd("hi rainbowcol1 guifg=#ffffff") -- Fix color of one rainbow parentheses which wasn't blending nicely with OneDark colorscheme

vim.cmd("highlight WinSeparator guibg=None") -- Crisp whiteline between windows
