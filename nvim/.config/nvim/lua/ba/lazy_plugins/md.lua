return {
  {
    "dkarter/bullets.vim",
    config = function()
      vim.g.bullets_enable_in_empty_buffers = 0
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        border = "rounded",
      })
      vim.api.nvim_create_user_command("Gloww", function(opts)
        local oldft = vim.bo.filetype
        local mainbuf = vim.api.nvim_get_current_buf()
        vim.bo[mainbuf].filetype = "markdown"
        vim.cmd.Glow({ args = opts.fargs })
        vim.bo[mainbuf].filetype = oldft
      end, { complete = "file", nargs = "?", bang = true })
    end,
    cmd = { "Glow", "Gloww" },
  },
  -- {
  -- It's 400mb plugin
  --   "euclio/vim-markdown-composer",
  --   build = "cargo build --release --locked",
  --   ft = { "markdown" },
  --   config = function()
  --     vim.g.markdown_composer_autostart = 0
  --     -- vim.g.markdown_composer_external_renderer = "pandoc -f markdown -t html"
  --     vim.g.markdown_composer_syntax_theme = "base16/solarized-light"
  --   end,
  -- },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({ theme = "light" })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
    ft = { "markdown" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  },
}
