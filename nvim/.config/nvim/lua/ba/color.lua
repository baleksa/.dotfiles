-- Set colorscheme in lazy plugin spec to avoid flickering when starting neovim
local function color_nvim()
  -- Set colorschemes for light bg
  local cc = "everforest"
  local llcc = "everforest"
  -- If bg=dark change accordingly
  if vim.o.background == "dark" then
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

vim.api.nvim_create_user_command(
  "ColorNvim",
  color_nvim,
  { desc = "Set colorscheme in according with background option." }
)

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = color_nvim,
})
