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

local plugins = {
  { "neovim/nvim-lspconfig" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "gq",
        "<Cmd>Format<Cr>",
        desc = "Format buffer",
      },
    },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shellharden", "shfmt" },
        bash = { "shfmt", "shellharden" },
        zsh = { "shellharden", "shfmt" },
        fennel = { "fnlfmt" },
        clojure = { "joker" },
        clojurescript = { "joker" },
        ["*"] = { "codespell" },
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        -- shfmt = {
        --   prepend_args = { "-i", "2" },
        -- },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({
          async = true,
          lsp_fallback = true,
          range = range,
        })
      end, { range = true })
    end,
  },
  {
    "NeogitOrg/neogit",
    -- cond = false,
    keys = {
      {
        "<leader>g",
        "<cmd>Neogit<cr>",
        desc = "Launch Neogit",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {},
    -- config = function(_, opts)
    --   require("neogit").setup(opts)
    -- end,
  },
  {
    "ibhagwan/fzf-lua",
    config = function()
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
      vim.keymap.set(
        "n",
        "<leader>sd",
        function()
          require("fzf-lua").grep_cword()
        end,
        { silent = true, desc = "Search files in cwd for word under cursor" }
      )
      vim.keymap.set("n", "<leader>sg", function()
        require("fzf-lua").grep_project()
      end, { silent = true, desc = "Live grep" })
      vim.keymap.set("n", "<leader>so", function()
        require("fzf-lua").btags()
      end, { silent = true, desc = "Search current buffer tags" })
      vim.keymap.set("n", "<leader>?", function()
        require("fzf-lua").oldfiles()
      end, { silent = true, desc = "Search previously opened files" })
      -- vim.keymap.set("n", "<leader>fcc", function()
      --   require("fzf-lua").colorschemes()
      -- end, { silent = true, desc = "Pick a colorscheme" })
      vim.api.nvim_create_autocmd("UIEnter", {
        group = vim.api.nvim_create_augroup("FzfDir", { clear = true }),
        callback = function()
          -- if vim.bo.filetype ~= "" and vim.bo.filetype ~= "oil" then
          --   return
          -- end
          -- if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) ~= 0 then
          --   require("fzf-lua").files()
          -- end
          if vim.bo.filetype == "oil" then
            require("fzf-lua").files()
          end
        end,
      })
    end,
  },
}

require("lazy").setup({
  spec = plugins,
})

require("ba.plugins.lsp")
