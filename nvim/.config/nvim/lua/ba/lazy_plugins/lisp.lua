local M = {
  { "Olical/nfnl", ft = "fennel" },
  { "Olical/aniseed" },
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python", "lua" },
    -- [Optional] cmp-conjure for cmp
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
    opts = {},
    config = function(_, _)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#debug"] = false

      -- Disable the documentation mapping
      vim.g["conjure#mapping#doc_word"] = false
      -- Rebind it from K to <prefix>gk
      vim.g["conjure#mapping#doc_word"] = "gk"
      vim.g["conjure#extract#tree_sitter#enabled"] = true

      vim.api.nvim_create_autocmd("BufNewFile", {
        group = vim.api.nvim_create_augroup(
          "conjure_log_disable_lsp",
          { clear = true }
        ),
        pattern = { "conjure-log-*" },
        callback = function()
          vim.diagnostic.disable(0)
        end,
        desc = "Conjure Log disable LSP diagnostics",
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.commentstring = ";; %s"
        end,
        desc = "Lisp style line comment",
        group = vim.api.nvim_create_augroup("comment_config", { clear = true }),
        pattern = { "clojure" },
      })
      vim.api.nvim_create_user_command(
        "Clj",
        "terminal clj -M:repl/conjure",
        {}
      )
    end,
  },
  {
    "julienvincent/nvim-paredit-fennel",
    dependencies = { "julienvincent/nvim-paredit" },
    ft = { "fennel" },
    opts = {},
  },
  -- {
  --   "julienvincent/nvim-paredit",
  --   ft = { "clojure", "fennel" },
  --   opts = {},
  -- },
  {
    "PaterJason/nvim-treesitter-sexp",
    ft = { "clojure", "fennel", "janet", "query" },
    opts = {
      -- Enable/disable
      enabled = true,
      -- Move cursor when applying commands
      set_cursor = true,
      -- Set to false to disable all keymaps
      keymaps = {
        -- Set to false to disable keymap type
        commands = {
          -- Set to false to disable individual keymaps
          swap_prev_elem = "<e",
          swap_next_elem = ">e",
          swap_prev_form = "<f",
          swap_next_form = ">f",
          promote_elem = "<LocalLeader>O",
          promote_form = "<LocalLeader>o",
          splice = "<LocalLeader>@",
          slurp_left = "<(",
          slurp_right = ">)",
          barf_left = ">(",
          barf_right = "<)",
          insert_head = "<I",
          insert_tail = ">I",
        },
        motions = {
          form_start = "(",
          form_end = ")",
          prev_elem = "[e",
          next_elem = "]e",
          prev_elem_end = "[E",
          next_elem_end = "]E",
          prev_top_level = "[[",
          next_top_level = "]]",
        },
        textobjects = {
          inner_elem = "ie",
          outer_elem = "ae",
          inner_form = "if",
          outer_form = "af",
          inner_top_level = "iF",
          outer_top_level = "aF",
        },
      },
    },
    config = function(_, opts)
      require("treesitter-sexp").setup(opts)
    end,
  },
  {
    "eraserhd/parinfer-rust",
    ft = { "clojure", "fennel", "lisp", "scheme" },
    -- opts = {},
    -- config = function(plugin, _)
    --   -- vim.opt.rtp:append(plugin.dir .. "target/release")
    -- end,
    build = "cargo build --release",
  },
}
return M
