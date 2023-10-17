return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
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
  { "tpope/vim-fugitive" }, -- Git commands in nvim
  { "tpope/vim-rhubarb" }, -- Fugitive-companion to interact with github
  { "tpope/vim-repeat" },
  { "kylechui/nvim-surround", version = "*", config = true },
  { "jcdickinson/wpm.nvim", config = true },
  -- Comment plugin written in Lua '
  { "numToStr/Comment.nvim", config = true },
  -- Automatic tags management,
  { "ludovicchabant/vim-gutentags" },
  -- Don't close vim and don't lose window layout when closing buffers
  { "moll/vim-bbye" },

  -- UI to select things (files, grep results, open buffers...)
  -- It sets vim.ui.select to telescope. That means for example that
  -- neovim core stuff can fill the telescope picker. Example would
  -- be lua vim.lsp.buf.code_action().
  { "nvim-telescope/telescope-ui-select.nvim" },
  -- Fzf algorithm in C too make telescope faster
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  { "stevearc/dressing.nvim" },
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

  { "lukas-reineke/indent-blankline.nvim" },

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
        -- See alse also the Plugins/Wezterm section in this projects README
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
  -- { "baleksa/simplebufline.nvim", dev = true },
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup({
        hide = {
          -- 	cursorline = true,
          only_win = true,
        },
        window = {
          margin = {
            vertical = 0,
          },
        },
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        filetypes_denylist = {
          "lir",
          "fugitive",
        },
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
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
    },
    config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
    end,
    lazy = false,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          {
            text = { builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            -- click = "v:lua.ScLa",
          },
          {
            sign = { name = { "GitSigns" }, maxwidth = 1, auto = true },
            -- click = "v:lua.ScSa",
          },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            -- click = "v:lua.ScSa",
          },
          -- {
          -- 	text = { "%s" },
          -- 	-- click = "v:lua.ScSa",
          -- },
          -- {
          -- 	text = { builtin.foldfunc },
          -- 	-- click = "v:lua.ScFa",
          -- },
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
}
