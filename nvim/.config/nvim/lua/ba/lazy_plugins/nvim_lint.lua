return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local selene = lint.linters.selene
    selene.args = {
      "--config",
      function() -- find selene.toml file
        local conf = vim.fs.find(
          { "selene.toml" },
          { type = "file", upward = true, path = vim.api.nvim_buf_get_name(0) }
        )[1]
        if conf == nil then
          conf = vim.fn.expand("~/.config/selene/selene.toml")[1]
        end
        return conf
      end,
      "--display-style",
      "json",
      "-",
    }
    lint.linters_by_ft = {
      lua = { "selene" },
      zsh = { "zsh" },
    }
    vim.api.nvim_create_autocmd(
      { "BufWritePost", "InsertLeave", "TextChanged" },
      {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
          lint.try_lint("codespell")
        end,
      }
    )
  end,
}
