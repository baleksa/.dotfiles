return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        comments = true,
        strings = false,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    -- cond = false,
  },
  {
    "tanvirtin/monokai.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {
      italics = false,
    },
  },
  {
    "shaunsingh/moonlight.nvim",
    lazy = true,
    -- priority = 1000,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    -- priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_enable_italic = 0
      vim.g.everforest_better_performance = 0
      -- vim.g.everforest_colors_override = {
      --   bg3 = {
      --     -- Color that the scheme uses for List Chars, Special Keys,
      --     -- Tab Line Label Background (inactive) is too bright
      --     "#DDD8BE",
      --     -- I think this is 256 based color
      --     -- if termguicolors is not set.
      --     -- This value is a random big number
      --     -- could be bad choice.
      --     "235",
      --   },
      -- }
    end,
    opts = {},
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    -- priority = 1000,
    -- cond = false,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    -- priority = 1000,
    opts = {
      disable_italics = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    -- lazy = false,
    priority = 1000,
    opts = {
      {
        theme = "tokyonight",
        style = "strom",
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        lualine_bold = true,
      },
    },
  },
  -- {
  -- 	"morhetz/gruvbox",
  -- 	config = function()
  -- 		vim.g.grubox_contrast_dark = "hard"
  -- 		vim.g.grubox_contrast_light = "hard"
  -- 		vim.g.gruvbox_italicize_comments = true
  -- 	end,
  -- },
}
