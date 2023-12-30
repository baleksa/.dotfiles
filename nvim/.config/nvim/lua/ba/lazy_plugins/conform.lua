return {
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
}
