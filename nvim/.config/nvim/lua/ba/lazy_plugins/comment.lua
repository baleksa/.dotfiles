return {
  {

    "JoosepAlviste/nvim-ts-context-commentstring",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          local lines = require("Comment.utils").get_lines(ctx.range)
          vim.fn.setreg("+", lines)
          ---@diagnostic disable-next-line: missing-return
          require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
        end,
      })
      ---@diagnostic disable-next-line: unknown-diag-code
      ---@diagnostic disable-next-line: global_usage, global_usage
      function _G.__toggle_contextual(vmode)
        local cfg = require("Comment.config"):get()
        local U = require("Comment.utils")
        local Op = require("Comment.opfunc")
        local range = U.get_region(vmode)
        local same_line = range.srow == range.erow

        local ctx = {
          cmode = U.cmode.toggle,
          range = range,
          cmotion = U.cmotion[vmode] or U.cmotion.line,
          ctype = same_line and U.ctype.linewise or U.ctype.blockwise,
        }

        local lcs, rcs = U.parse_cstr(cfg, ctx)
        local lines = U.get_lines(range)

        local params = {
          range = range,
          lines = lines,
          cfg = cfg,
          cmode = ctx.cmode,
          lcs = lcs,
          rcs = rcs,
        }

        if same_line then
          Op.linewise(params)
        else
          Op.blockwise(params)
        end
      end

      vim.keymap.set(
        "n",
        "<C-c>",
        "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@"
      )
      vim.keymap.set(
        "x",
        "<C-c>",
        "<cmd>set operatorfunc=v:lua.__toggle_contextual<CR>g@"
      )
    end,
  },
}
