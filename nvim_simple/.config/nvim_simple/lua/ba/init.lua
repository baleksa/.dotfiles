vim.loader.enable()

require("ba.opt")
require("ba.lazy_init")
require("ba.statusline")
require("ba.lsp")
require("ba.keys")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
      on_visual = false,
    })
  end,
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
})

-- Disable semantic highlighting
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- Set keywords bold, comments italic
vim.api.nvim_create_autocmd("Colorscheme", {
  group = vim.api.nvim_create_augroup("Fix colorscheme", {}),
  callback = function()
    vim.cmd([[highlight Keyword gui=bold]])
    vim.cmd([[highlight Comment gui=italic]])
  end,
})

-- vim.api.nvim_create_autocmd("OptionSet", {
--   pattern = "background",
--   callback = function() end,
--   group = 1,
-- })

vim.cmd.colorscheme("quiet")
