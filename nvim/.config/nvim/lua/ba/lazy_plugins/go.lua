return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    diagnostic = false,
  },
  config = function(_, opts)
    require("go").setup(opts)
  end,
  -- event = { "CmdlineEnter" },
  ft = { "go", "gomod", "gohtmltmpl", "gotexttmpl" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
