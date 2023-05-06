local function color_nvim()
	-- Set colorschemes for light bg
	local cc = "everforest"
	local llcc = "everforest"
	-- If bg=dark change accordingly
	if vim.opt.background:get() == "dark" then
		cc = "tokyonight"
		llcc = "tokyonight"
	end

	vim.cmd.colorscheme(cc)
	require("lualine").setup({
		options = {
			theme = llcc,
		},
	})
end

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		color_nvim()
	end,
})

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		color_nvim()
	end,
})
