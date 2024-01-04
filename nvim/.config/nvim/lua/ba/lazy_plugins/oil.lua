local M = {
  {
    "stevearc/oil.nvim",
    cond = function()
      return vim.g.file_explorer == "oil"
    end,
    opts = {
      default_file_explorer = true,
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        {
          "icon",
          default_file = "",
          directory = "",
          highlight = function(value)
            if value.type == "directory" then
              return "OilDir"
            else
              return "Normal"
            end
          end,
        },
        -- {
        -- 	-- icon = "",
        -- 	-- color = "#7ebae4",
        -- 	-- name = "LirFolderNode",
        -- },
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        -- bufhidden = "delete",
      },
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        -- concealcursor = "n",
      },
      -- Restore window options to previous values when leaving an oil buffer
      restore_win_options = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = true,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 60,
        max_height = 20,
        border = "rounded",
        win_options = {
          winblend = 20,
        },
      },
    },
    config = function(_, opts)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("oil").setup(opts)

      vim.keymap.set("n", "<leader>-", function()
        require("oil").toggle_float()
      end, { desc = "Open parent directory" })

      vim.keymap.set(
        "n",
        "-",
        "<cmd>Oil<cr>",
        { desc = "Open parent directory" }
      )
      -- vim.schedule(function()
      --   vim.api.nvim_set_hl(0, "OilDir", { fg = "#3a94c5" })
      -- end)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "OilDir", { fg = "#3a94c5" })
        end,
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}

return M
