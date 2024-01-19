local M = {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = {
        add = { text = "🮇" }, -- text = "+", },
        change = { text = "🮇" }, -- text = "~", },
        delete = { text = "_" }, -- text = "🮇", },
        topdelete = { text = "‾" }, -- text = "🮇", },
        changedelete = { text = "~" }, -- text = "🮇", },
        untracked = { text = "┊" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]g", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[g", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        -- map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        -- map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        -- map("n", "<leader>hS", gs.stage_buffer)
        -- map("n", "<leader>hu", gs.undo_stage_hunk)
        -- map("n", "<leader>hR", gs.reset_buffer)
        -- map("n", "<leader>hp", gs.preview_hunk)
        -- map("n", "<leader>hb", function()
        -- 	gs.blame_line({ full = true })
        -- end)
        -- map("n", "<leader>tb", gs.toggle_current_line_blame)
        -- map("n", "<leader>hd", gs.diffthis)
        -- map("n", "<leader>hD", function()
        -- 	gs.diffthis("~")
        -- end)
        -- map("n", "<leader>td", gs.toggle_deleted)
        --
        -- -- Text object
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
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
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {},
    -- config = function(_, opts)
    --   require("neogit").setup(opts)
    -- end,
  },
  {
    "pwntester/octo.nvim",
    -- cond = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {
      picker = "fzf-lua",
      mappings = {},
    },
  },
}
return M
