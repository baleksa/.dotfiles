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

-- Turn relative numbers in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("IE", {}),
  callback = function()
    vim.o.rnu = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("IL", {}),
  callback = function()
    vim.o.rnu = true
    vim.o.nu = true
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  group = vim.api.nvim_create_augroup("ColorNvim", {}),
  callback = function()
    vim.schedule(function()
      vim.cmd.colorscheme(vim.o.background)
    end)
  end,
})
