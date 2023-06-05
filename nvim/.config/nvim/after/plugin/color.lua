-- There is a race confition between checking if bg is set and auto detecting bg
-- so setting colors and highlight is buggy af
-- https://github.com/neovim/neovim/issues/22614

local function color_nvim()
  -- Set colorschemes for light bg
  local cc = "everforest"
  -- If bg=dark change accordingly
  if vim.o.background == "dark" then
    cc = "tokyonight"
  end

  local nvcc = cc
  local llcc = cc

  vim.cmd.colorscheme(nvcc)
  require("lualine").setup({
    options = {
      theme = llcc,
    },
  })

  -- Because of a racing confition without this line highlights are not set on
  -- startup
  -- Done by VimEnter autocmd bellow
  -- require("nvim-web-devicons").set_up_highlights()
end

local color_lua = vim.api.nvim_create_augroup("ColorLua", {})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = color_nvim,
  group = color_lua,
})

-- Because of https://github.com/neovim/neovim/issues/22614, without this autocmd
-- highlights are not set when term background is light
-- This can be fixed by using vim.schedule in web-devicons config function but that way
-- screen flickers
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   callback = function()
--     require("nvim-web-devicons").set_up_highlights()
--   end,
-- })

-- if vim.o.bg == "dark" then
--   vim.cmd.colorscheme("tokyonight")
--   require("lualine").setup({
--     options = {
--       theme = "tokyonight",
--     },
--   })
-- end
