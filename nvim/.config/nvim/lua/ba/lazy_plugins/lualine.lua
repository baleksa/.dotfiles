local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
}

function M.config()
  require("lualine").setup({
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_x = {
        require("wpm").wpm,
        require("wpm").historic_graph,
        "encoding",
        {
          "fileformat",
          symbols = {
            unix = "󰌽",
          },
        },
        "filetype",
      },
    },
  })
end

return M
