vim.g.status_line = "cokeline"
vim.g.file_explorer = "lir"

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
	install = { colorscheme = { "everforest", "shine" } },
	-- checker = { enabled = true },
	-- diff = {
	--   cmd = "terminal_git",
	-- },
	-- performance = {
	--   cache = {
	--     enabled = true,
	--     -- disable_events = {},
	--   },
	--   rtp = {
	--     disabled_plugins = {
	--       "gzip",
	--       "matchit",
	--       "matchparen",
	--       "netrwPlugin",
	--       "tarPlugin",
	--       "tohtml",
	--       "tutor",
	--       "zipPlugin",
	--       "nvim-treesitter-textobjects",
	--     },
	--   },
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
-- vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>")
