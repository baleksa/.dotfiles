local M = {
  "tamago324/lir.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cond = function()
    return vim.g.file_explorer == "lir"
  end,
}

function M.config()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  local actions = require("lir.actions")
  local mark_actions = require("lir.mark.actions")
  local clipboard_actions = require("lir.clipboard.actions")

  require("lir").setup({
    hide_cursor = true,
    show_hidden_files = false,
    ignore = {}, -- { ".DS_Store" "node_modules" } etc.
    devicons = {
      enable = true,
      highlight_dirname = false,
    },
    mappings = {
      ["l"] = actions.edit,
      ["<CR>"] = actions.edit,
      ["<C-s>"] = actions.split,
      ["<C-v>"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,

      ["h"] = actions.up,
      ["-"] = actions.up,
      ["q"] = actions.quit,

      ["K"] = actions.mkdir,
      ["N"] = actions.newfile,
      ["R"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["."] = actions.toggle_show_hidden,
      ["D"] = actions.delete,

      ["J"] = function()
        mark_actions.toggle_mark()
        vim.cmd("normal! j")
      end,
      ["C"] = clipboard_actions.copy,
      ["X"] = clipboard_actions.cut,
      ["P"] = clipboard_actions.paste,
    },
    float = {
      curdir_window = {
        enable = false,
        highlight_dirname = false,
      },
      -- You can define a function that returns a table to be passed as the third
      -- argument of nvim_open_win().
      win_opts = function()
        return {
          border = "rounded",
        }
      end,
    },
    on_init = function()
      -- Because of https://github.com/neovim/neovim/issues/22614 wrap in
      -- vim.schedule to echo message with proper color
      vim.schedule(function()
        -- use visual mode
        vim.api.nvim_buf_set_keymap(
          0,
          "x",
          "J",
          ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
          { noremap = true, silent = true }
        )

        -- echo cwd
        vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
      end)
    end,
  })

  local lir_au = vim.api.nvim_create_augroup("Lir", { clear = true })

  vim.schedule(function()
    vim.api.nvim_set_hl(0, "LirFloatBorder", { link = "Normal" })
    vim.cmd([[
	highlight def LirTransparentCursor gui=strikethrough blend=100
    ]])
  end)

  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      vim.api.nvim_set_hl(0, "LirFloatBorder", { link = "Normal" })
      vim.cmd([[
	highlight def LirTransparentCursor gui=strikethrough blend=100
	]])
    end,
    group = lir_au,
  })

  vim.api.nvim_create_autocmd({ "OptionSet" }, {
    pattern = "background",
    callback = function()
      require("nvim-web-devicons").set_icon({
        lir_folder_icon = {
          icon = "",
          color = "#7ebae4",
          name = "LirFolderNode",
        },
      })
    end,
    group = lir_au,
  })

  vim.keymap.set(
    "n",
    "-",
    [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]],
    { noremap = true }
  )
  vim.keymap.set("n", "<leader>-", function()
    require("lir.float").toggle()
  end, { noremap = true })
end

return M
