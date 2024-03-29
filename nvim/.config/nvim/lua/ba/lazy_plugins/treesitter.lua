local disable = function(lang, bufnr)
  local function str_in_list(list, str)
    for _, v in ipairs(list) do
      if v == str then
        return true
      end
    end
    return false
  end
  local disable_list = {
    "zig",
  }
  if str_in_list(disable_list, lang) then
    return true
  end
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  if line_count > vim.g.too_large_file_lnum then
    return true
  end
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- cond = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "RRethy/nvim-treesitter-endwise",
    },
    -- init = function()
    -- end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {},
        ignore_install = {},
        sync_install = false,
        auto_install = true,
        modules = {},
        endwise = {
          enable = true,
        },
        playground = {
          enable = true,
          disable = function(lang, bufnr)
            if disable(lang, bufnr) then
              return true
            end
          end,
          -- Debounced time for highlighting nodes in the playground from source code
          updatetime = 25,
          -- Whether the query persists across vim sessions
          persist_queries = false,
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
        highlight = {
          enable = true,
          -- disable = { "help", },
          disable = function(lang, bufnr)
            if disable(lang, bufnr) then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = function(lang, bufnr)
            if disable(lang, bufnr) then
              return true
            end
          end,
        },
        matchup = {
          enable = true,
          disable = function(lang, bufnr)
            if disable(lang, bufnr) then
              return true
            end
          end,
        },
        incremental_selection = {
          enable = true,
          disable = function(lang, bufnr)
            if disable(lang, bufnr) then
              return true
            end
          end,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            disable = function(lang, bufnr)
              if disable(lang, bufnr) then
                return true
              end
            end,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region",
              },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = {
                query = "@scope",
                query_group = "locals",
                desc = "Select language scope",
              },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            disable = function(lang, bufnr)
              if disable(lang, bufnr) then
                return true
              end
            end,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
      disable = function(lang, bufnr)
        if disable(lang, bufnr) then
          return true
        end
      end,
    },
  },
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    -- cond = false,
    config = function()
      -- This module contains a number of default definitions
      local rainbow = require("rainbow-delimiters")

      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = function(bufnr)
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            if line_count > vim.g.too_large_file_lnum then
              return nil
            elseif line_count > 1000 then
              return rainbow.strategy["global"]
            end
            return rainbow.strategy["local"]
          end,
          clojure = rainbow.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        blacklist = {
          "zig",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
  {
    -- Treesitter is disabled because it's too slow, it takles 2s for neovim to start
    -- with ts enabled  for zig
    "ziglang/zig.vim",
  },
}
