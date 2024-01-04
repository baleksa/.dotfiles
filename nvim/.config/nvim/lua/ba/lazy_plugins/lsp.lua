return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "PaterJason/cmp-conjure",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp = require("cmp")
      local cmp_format = require("lsp-zero").cmp_format()
      local cmp_action = require("lsp-zero").cmp_action()

      cmp.setup({
        formatting = cmp_format,
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "buffer", keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
          { name = "conjure" },
          { name = "crates" },
        },
        sorting = {
          comparators = {
            require("clangd_extensions.cmp_scores"),
          },
        },
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Ctrl+Space to trigger completion menu
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),

          -- Scroll up and down in the completion documentation
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
        }),
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline({}),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({ select = true }),
            { "i", "c" }
          ),
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  {
    "smjonas/inc-rename.nvim",
    opts = { input_buffer_type = "dressing" },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "folke/neodev.nvim", -- for better Lua dev experience
      "smjonas/inc-rename.nvim",
      "simrat39/symbols-outline.nvim",
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      -- lsp-zero will use default setup config for all installed and available server

      local lsp_zero = require("lsp-zero")
      local lspconfig = require("lspconfig")

      lsp_zero.set_sign_icons({
        error = "󰅘",
        -- error = "✖", -- this can only be used in the git_status source
        warn = "󰔷",
        -- warn = "▲",
        hint = "",
        -- hint = "⚑",
        -- info = "",
        info = "",
      })

      vim.diagnostic.config({
        virtual_text = false,
        underline = false,
        float = { source = true, border = "rounded" },
        update_in_insert = false,
      })

      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = { "n:i", "v:s" },
        desc = "Disable diagnostics in insert and select mode",
        callback = function(e)
          vim.diagnostic.disable(e.buf)
        end,
      })
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "i:n",
        desc = "Enable diagnostics when leaving insert mode",
        callback = function(e)
          vim.diagnostic.enable(e.buf)
        end,
      })

      local common_on_attach = function(client, bufnr)
        vim.lsp.set_log_level("ERROR")

        local bufopts = { silent = true, buffer = bufnr }
        local bind = function(m, lhs, rhs, opts)
          opts = opts or {}
          vim.keymap.set(m, lhs, rhs, vim.tbl_extend("force", bufopts, opts))
        end

        if client.config.root_dir then
          vim.api.nvim_set_current_dir(client.config.root_dir)
        end
        if
          client.server_capabilities.documentSymbolProvider
          and client.name ~= "standardrb"
        then
          require("nvim-navic").attach(client, bufnr)
        end

        bind({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
        -- bind("i", "<C-h>", vim.lsp.buf.signature_help)
        --
        bind("n", "<leader>rn", function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { expr = true, desc = "Rename ident under cursor" })

        bind("n", "<leader>d", function()
          vim.diagnostic.open_float({ source = true })
        end)
        bind("n", "[d", function()
          vim.diagnostic.goto_prev({ float = { source = true } })
        end)
        bind("n", "]d", function()
          vim.diagnostic.goto_next({ float = { source = true } })
        end)
        -- bind("n", "[e", function()
        --   vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
        -- end)
        -- bind("n", "]e", function()
        --   vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        -- end)

        bind("n", "<leader>o", "<cmd>SymbolsOutline<CR>")
      end

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          omit = { "gl" },
          preserve_mappings = false,
        })
        common_on_attach(client, bufnr)
      end)

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          rust_analyzer = function()
            local extension_path = vim.fn.stdpath("data")
              .. "/mason/packages/codelldb/extension"
            local codelldb_path = extension_path .. "/adapter/codelldb"
            local liblldb_path = extension_path .. "/lldb/lib/liblldb.so" -- MacOS: This may be .dylib

            local rust_tools = require("rust-tools")
            rust_tools.setup({
              server = {
                on_attach = function(_, bufnr)
                  vim.keymap.set(
                    "n",
                    "<leader>ha",
                    rust_tools.hover_actions.hover_actions,
                    { buffer = bufnr }
                  )
                end,
              },
              -- hover_actions = {
              -- 	auto_focus = true,
              -- },
              dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(
                  codelldb_path,
                  liblldb_path
                ),
              },
            })
          end,
          jdtls = lsp_zero.noop,
          lua_ls = function()
            -- local lua_opts = lsp_zero.nvim_lua_ls()
            require("neodev").setup({})
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  format = {
                    enable = false,
                  },
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
          pylsp = function()
            -- Doesn't work if called from single file in home directory.
            -- Sometimes uses a lot of CPU.
            -- Learn how mypy and rope work so you know how to configurethem.
            lspconfig.pylsp.setup({
              settings = {
                pylsp = {
                  plugins = {
                    ruff = {
                      enabled = true,
                      extendSelect = { "I", "W", "Q", "B", "D" },
                      lineLength = 88,
                      format = { "I" },
                      unsafeFixes = true,
                    },
                    -- rope_autoimport = { enabled = true },
                    -- rope_completion = { enabled = true },
                    -- Ruff disables them all
                    -- autopep8 = { enabled = false },
                    -- flake8 = { enabled = false },
                    -- mccabe = { enabled = false },
                    -- pycodestyle = { enabled = false },
                    -- pyflakes = { enabled = false },
                    -- pylint = { enabled = false },
                    -- yapf = { enabled = false },
                  },
                },
              },
              single_file_support = true,
            })
          end,
          fennel_language_server = function()
            lspconfig.fennel_language_server.setup({
              root_dir = lspconfig.util.root_pattern("fnl", "lua"),
              settings = {
                fennel = {
                  workspace = {
                    -- If you are using hotpot.nvim or aniseed,
                    -- make the server aware of neovim runtime files.
                    library = vim.api.nvim_list_runtime_paths(),
                  },
                  diagnostics = {
                    globals = { "vim", "jit", "comment" },
                  },
                },
              },
            })
          end,
          bashls = function()
            lspconfig.bashls.setup({
              filetypes = {
                "sh",
                "bash",
                "zsh",
                ".bash_login",
                ".bash_logout",
                ".bash_profile",
                ".bashrc",
                ".profile",
                ".zshenv",
                ".zlogin",
                ".zlogout",
                ".zprofile",
                ".zshrc",
                "APKBUILD",
                "PKGBUILD",
                ".bash_aliases",
              },
            })
          end,
          prosemd_lsp = function()
            lspconfig.prosemd_lsp.setup({
              on_attach = function(client, _)
                if
                  not vim.list_contains(vim.opt_local.spelllang:get(), "en")
                then
                  client:stop()
                end
              end,
            })
          end,
        },
      })

      lspconfig.fennel_ls.setup({
        root_dir = lspconfig.util.root_pattern("fnl", "lua"),
        settings = {
          ["fennel-ls"] = {
            workspace = {
              -- If you are using hotpot.nvim or aniseed,
              -- make the server aware of neovim runtime files.
              library = vim.api.nvim_list_runtime_paths(),
            },
            ["extra-globals"] = table.concat({ "vim", "jit", "comment" }, " "),
          },
        },
      })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
  },
  {
    url = "https://git.sr.ht/~p00f/clangd_extensions.nvim",
    -- dependencies = {
    -- 	"VonHeikemen/lsp-zero.nvim",
    -- },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          only_current_line = true,
        },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    -- cond = false,
    opts = {
      handler_opts = {
        border = "rounded",
      },
      floating_window = false,
      floating_window_above_cur_line = true,
      hint_prefix = "➡️ ",
      padding = " ",
      zindex = 40,
      toggle_key = "<C-h>",
    },
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      highlight = true,
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      attach_navic = false,
    },
  },
  {
    "saecki/crates.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- version = "v0.3.0",
    opts = {
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
    event = "BufRead Cargo.toml",
  },
}
