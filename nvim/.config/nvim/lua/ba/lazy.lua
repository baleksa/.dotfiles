-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("ba.lazy_plugins", {
  -- defaults = { lazy = true },
  dev = { path = "~/coding/nvim_plugins" },
  -- install = {
  -- 	colorscheme = {
  -- 		-- If you put colorschemes that set vim.g.background
  -- 		-- option to different values here it can lead to
  -- 		-- strange behaviour
  -- 		-- "everforest",
  -- 	},
  -- },
  -- checker = { enabled = true },
  -- diff = {
  --   cmd = "terminal_git",
  -- },
  -- performance = {
  --   cache = {
  --     enabled = true,
  --     -- disable_events = {},
  --   },
  rtp = {
    disabled_plugins = {
      "gzip",
      "matchit",
      "matchparen",
      "netrwPlugin",
      "netrw",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
  -- },
  -- -- ui = {
  -- --   custom_keys = {
  -- --
  -- --     ["<localleader>d"] = function(plugin)
  -- --       dd(plugin)
  -- --     end,
  -- --   },
  -- -- },
  -- debug = true,
})

if vim.g.file_explorer == "netrw" then
  require("ba.netrw").setup()
end
