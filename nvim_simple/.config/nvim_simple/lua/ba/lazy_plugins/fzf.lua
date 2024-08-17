local M = {
  "ibhagwan/fzf-lua",
}

function M.config(_, opts)
  require("fzf-lua").setup({
    keymap = {
      builtin = {},
      fzf = {
        -- ["ctrl-k"] = "up",
        -- ["ctrl-j"] = "down",
      },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "fzf",
    callback = function()
      vim.keymap.set({ "n", "t" }, "<c-k>", "<c-k>", { buffer = true })
      vim.keymap.set({ "n", "t" }, "<c-j>", "<c-j>", { buffer = true })
      vim.keymap.set({ "n", "t" }, "<c-h>", "<c-h>", { buffer = true })
      vim.keymap.set({ "n", "t" }, "<c-l>", "<c-l>", { buffer = true })
    end,
    group = vim.api.nvim_create_augroup("FzfMap", { clear = true }),
  })

  vim.keymap.set("n", "<leader><space>", function()
    require("fzf-lua").buffers()
  end, { silent = true, desc = "Search opened buffers" })
  vim.keymap.set("n", "<leader>sf", function()
    require("fzf-lua").files()
  end, { silent = true, desc = "Search files in cwd" })
  vim.keymap.set("n", "<leader>sb", function()
    require("fzf-lua").grep_curbuf()
  end, { silent = true, desc = "Fuzzy search current buffer" })
  vim.keymap.set("n", "<leader>sh", function()
    require("fzf-lua").help_tags()
  end, { silent = true, desc = "Search help documentation" })
  vim.keymap.set("n", "<leader>st", function()
    require("fzf-lua").tags()
  end, { silent = true, desc = "Search tags" })
  vim.keymap.set("n", "<leader>sd", function()
    require("fzf-lua").grep_cword()
  end, {
    silent = true,
    desc = "Search files in cwd for word under cursor",
  })
  vim.keymap.set("n", "<leader>sg", function()
    require("fzf-lua").grep_project()
  end, { silent = true, desc = "Live grep" })
  vim.keymap.set("n", "<leader>so", function()
    require("fzf-lua").btags()
  end, { silent = true, desc = "Search current buffer tags" })
  vim.keymap.set("n", "<leader>?", function()
    require("fzf-lua").oldfiles()
  end, { silent = true, desc = "Search previously opened files" })
  vim.keymap.set("n", "<leader>cc", function()
    require("fzf-lua").colorschemes()
  end, { silent = true, desc = "Pick a colorscheme" })
  vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("FzfDir", { clear = true }),
    callback = function()
      if vim.bo.filetype == "netrw" then
        require("fzf-lua").files()
      end
    end,
  })
end

return M
