local plugins = {
  -- Colorschemes
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  { "plan9-for-vimspace/acme-colors" },
  { "sainnhe/everforest" },
  { "slugbyte/lackluster.nvim" },

  { "neovim/nvim-lspconfig" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "go",
        "lua",
        "markdown",
        "vimdoc",
        "markdown_inline",
      },
    },
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
      -- "ibhagwan/fzf-lua", -- optional
    },
    opts = {},
    -- config = function(_, opts)
    --   require("neogit").setup(opts)
    -- end,
  },
}

return plugins
