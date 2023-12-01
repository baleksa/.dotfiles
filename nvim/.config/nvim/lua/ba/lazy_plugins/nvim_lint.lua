return {
  "mfussenegger/nvim-lint",
  config = function()
    local selene = require("lint").linters.selene
    selene.args = {
      "--config",
      function()
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
    require("lint").linters_by_ft = {
      lua = { "selene" },
    }
    vim.api.nvim_create_autocmd(
      { "BufWritePost", "InsertLeave", "TextChanged" },
      {
        callback = function()
          require("lint").try_lint()
        end,
      }
    )
  end,
}
