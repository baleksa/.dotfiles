local plugins = {
  -- Colorschemes
  { "nyoom-engineering/oxocarbon.nvim" },
  { "plan9-for-vimspace/acme-colors" },
  { "sainnhe/everforest" },
  -- { "overvale/vacme" },
  -- { "raphael-proust/vacme" },
  -- {
  --   "RRethy/base16-nvim",
  --   opts = {
  --     base00 = "#ffffea",
  --     base01 = "#2c313c",
  --     base02 = "#3e4451",
  --     base03 = "#6c7891",
  --     base04 = "#",
  --     base05 = "#000000",
  --     base06 = "#9a9bb3",
  --     base07 = "#c5c8e6",
  --     base08 = "#e06c75",
  --     base09 = "#d19a66",
  --     base0A = "#e5c07b",
  --     base0B = "#98c379",
  --     base0C = "#56b6c2",
  --     base0D = "#0184bc",
  --     base0E = "#c678dd",
  --     base0F = "#a06949",
  --   },
  -- },

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
  },
}

return plugins
