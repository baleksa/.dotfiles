return {
  {
    -- opts = function()
    --   return {
    --     color_icons = true,
    --   }
    -- end,
    -- config = function(_, opts)
    --   require("nvim-web-devicons").setup(opts)
    --   -- Fixed by VimEnter autocmd in after/plugin/color.lua
    --   -- Using vim.schedule() here makes the screen flicker
    --   -- vim.schedule(function()
    --   --   require("nvim-web-devicons").set_up_highlights()
    --   -- end)
    --   require("nvim-web-devicons").set_default_icon("", "#6d8086", 65)
    -- end,
  },
  -- tpope's phenomenal plugins
  { "tpope/vim-repeat" },
  { "kylechui/nvim-surround", version = "*", opts = {}, event = "VeryLazy" },
  { "jcdickinson/wpm.nvim", config = true },
  -- Comment plugin written in Lua '
  -- Automatic tags management,
  { "ludovicchabant/vim-gutentags" },
  -- Don't close vim and don't lose window layout when closing buffers
  { "moll/vim-bbye" },

  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        backend = {
          -- "telescope",
          "fzf_lua",
          "fzf",
        },
      },
    },
  },
  { "chrisgrieser/nvim-ghengis", dependencies = "stevearc/dressing.nvim" },

  {
    "akinsho/toggleterm.nvim",
    branch = "main",
    opts = {
      open_mapping = [[<c-\>]],
      autochdir = true,
    },
  }, -- Spawn multiple terminals in nvim with many orientations and send commands to them

  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    -- cond = false,
    dependencies = {
      "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    },
    main = "ibl",
    opts = {
      indent = { char = "┆" },
      scope = {
        show_start = false,
        show_end = false,
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        include = {
          node_type = { lua = { "return_statement", "table_constructor" } },
        },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },
  { "folke/trouble.nvim", config = true },
  {
    "folke/twilight.nvim",
    -- Dim inactive portions of code
    config = true,
  },
  {
    "folke/zen-mode.nvim",
    -- Hides everything except buffer content and enters fullscreen
    opts = {
      options = {
        signcolumn = true, -- disable signcolumn
        number = true, -- disable number column
        relativenumber = true, -- disable relative numbers
        cursorline = true, -- disable cursorline
        cursorcolumn = true, -- disable cursor column
        foldcolumn = true, -- disable fold column
        list = true, -- disable whitespace characters
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = true, -- disables the ruler text in the cmd line area
          showcmd = true, -- disables the command in the last line of the screen
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        -- this will change the font size on wezterm when in zen mode
        -- See also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
      on_open = function()
        require("barbecue.ui").toggle(false)
      end,
      on_close = function()
        require("barbecue.ui").toggle(true)
      end,
    },
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end,
  },

  { "prichrd/netrw.nvim" },
  { "godlygeek/tabular" }, -- Vim script for text filtering and alignment,

  { "andymass/vim-matchup" }, -- More options to do on matching text and extends vim's %,

  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = true,
  },
  {
    "nacro90/numb.nvim",
    opts = {},
  },
  -- { "baleksa/simplebufline.nvim", dev = true },
  {
    "b0o/incline.nvim",
    opts = {
      hide = {
        -- 	cursorline = true,
        only_win = true,
      },
      window = {
        margin = {
          vertical = 0,
        },
      },
      -- ignore = {
      --   buftypes = { "terminal" },
      -- },
    },
  },
  {
    "RRethy/vim-illuminate",
    -- cond = false,
    config = function()
      require("illuminate").configure({
        filetypes_denylist = {
          "lir",
          "fugitive",
        },
        large_file_cutoff = vim.g.too_large_file_lnum,
      })
    end,
  },
  { "shortcuts/no-neck-pain.nvim", opts = { buffers = {} } },
  { "RaafatTurki/hex.nvim", config = true },
  { "vim-scripts/Decho" },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      scope = "window",
      colorcolumn = "88",
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "lazy",
        "mason",
      },
    },
  },
  { "timmyjose-projects/lox.vim" },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = {
  --     "kevinhwang91/promise-async",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   event = "BufRead",
  --   keys = {
  --     {
  --       "zR",
  --       function()
  --         require("ufo").openAllFolds()
  --       end,
  --     },
  --     {
  --       "zM",
  --       function()
  --         require("ufo").closeAllFolds()
  --       end,
  --     },
  --     {
  --       "K",
  --       function()
  --         local winid = require("ufo").peekFoldedLinesUnderCursor()
  --         if not winid then
  --           vim.lsp.buf.hover()
  --         end
  --       end,
  --     },
  --   },
  --   config = function()
  --     vim.o.foldcolumn = "1" -- '0' is not bad
  --     vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --
  --     require("ufo").setup({
  --       provider_selector = function(bufnr, filetype, buftype)
  --         return { "treesitter", "indent" }
  --       end,
  --     })
  --   end,
  -- },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
    end,
    lazy = false,
  },
  { "sitiom/nvim-numbertoggle" },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- relculright = true,
        segments = {
          {
            sign = {
              name = { "Diagnostic.*" },
              maxwidth = 1,
              auto = false,
            },
          },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
          },
          {
            sign = {
              namespace = { "gitsigns.*" },
              maxwidth = 1,
              auto = false,
            },
          },
        },
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "phaazon/hop.nvim",
    config = function()
      -- place this in one of your configuration file(s)
      local hop = require("hop")
      hop.setup()
      local directions = require("hop.hint").HintDirection
      vim.keymap.set("", "f", function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true,
        })
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true,
        })
      end, { remap = true })
      vim.keymap.set("", "t", function()
        hop.hint_char1({
          direction = directions.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        })
      end, { remap = true })
      vim.keymap.set("", "T", function()
        hop.hint_char1({
          direction = directions.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1,
        })
      end, { remap = true })
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    opts = {},
    cond = function()
      return vim.g.file_explorer == "mini"
    end,
    config = function(_, opts)
      require("mini.files").setup(opts)
      vim.keymap.set("n", "-", function()
        MiniFiles.open()
      end, {})
      vim.keymap.set("n", "<leader>-", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, {})
    end,
  },
  -- {
  --   "chrisgrieser/nvim-spider",
  --   opts = {},
  --   config = function(_, opts)
  --     require("spider").setup(opts)
  --     vim.keymap.set(
  --       { "n", "o", "x" },
  --       "w",
  --       "<cmd>lua require('spider').motion('w')<CR>",
  --       { desc = "Spider-w" }
  --     )
  --     vim.keymap.set(
  --       { "n", "o", "x" },
  --       "e",
  --       "<cmd>lua require('spider').motion('e')<CR>",
  --       { desc = "Spider-e" }
  --     )
  --     vim.keymap.set(
  --       { "n", "o", "x" },
  --       "b",
  --       "<cmd>lua require('spider').motion('b')<CR>",
  --       { desc = "Spider-b" }
  --     )
  --     vim.keymap.set(
  --       { "n", "o", "x" },
  --       "ge",
  --       "<cmd>lua require('spider').motion('ge')<CR>",
  --       { desc = "Spider-ge" }
  --     )
  --   end,
  -- },
  {
    "VonHeikemen/searchbox.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    keys = {
      {
        mode = "n",
        "<leader>ss",
        "<cmd>SearchBoxIncSearch<cr>",
      },
      {
        mode = "n",
        "<leader>sr",
        "<cmd>SearchBoxReplace<cr>",
      },
      {
        mode = "x",
        "<leader>s",
        "<cmd>SearchBoxIncSearch visual_mode=true<cr>",
      },
    },
    opts = {},
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    keys = {
      {
        mode = "n",
        "<CR>",
        "<cmd>FineCmdline<cr>",
      },
    },
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    opts = {},
  },
}
