return {
  {
    "ibhagwan/fzf-lua",
    config = function()
      vim.keymap.set("n", "<leader><space>", function()
        require("fzf-lua").buffers()
      end, { silent = true, desc = "Search opened buffers" })
      vim.keymap.set("n", "<leader>sf", function()
        require("fzf-lua").files()
      end, { silent = true, desc = "Search files in cwd" })
      vim.keymap.set("n", "<leader>sb", function()
        require("fzf-lua").grep_curbuf()
      end, { silent = true, desc = "Fuzzy search current buffer" })
      vim.keymap.set("n", "<leader>sh", function()
        require("fzf-lua").help_tags()
      end, { silent = true, desc = "Search help documentation" })
      vim.keymap.set("n", "<leader>st", function()
        require("fzf-lua").tags()
      end, { silent = true, desc = "Search tags" })
      vim.keymap.set(
        "n",
        "<leader>sd",
        function()
          require("fzf-lua").grep_cword()
        end,
        { silent = true, desc = "Search files in cwd for word under cursor" }
      )
      vim.keymap.set("n", "<leader>sg", function()
        require("fzf-lua").grep_project()
      end, { silent = true, desc = "Live grep" })
      vim.keymap.set("n", "<leader>so", function()
        require("fzf-lua").btags()
      end, { silent = true, desc = "Search current buffer tags" })
      vim.keymap.set("n", "<leader>?", function()
        require("fzf-lua").oldfiles()
      end, { silent = true, desc = "Search previously opened files" })
      -- vim.keymap.set("n", "<leader>fcc", function()
      --   require("fzf-lua").colorschemes()
      -- end, { silent = true, desc = "Pick a colorscheme" })
    end,
  },
 --  {
 --    "junegunn/fzf",
 --    init = function()
 --      vim.cmd([[
	-- let g:fzf_colors =
	-- \ { 'fg':         ['fg', 'Normal'],
	--   \ 'bg':         ['bg', 'Normal'],
	--   \ 'preview-bg': ['bg', 'NormalFloat'],
	--   \ 'hl':         ['fg', 'Comment'],
	--   \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	--   \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
	--   \ 'hl+':        ['fg', 'Statement'],
	--   \ 'info':       ['fg', 'PreProc'],
	--   \ 'border':     ['fg', 'Ignore'],
	--   \ 'prompt':     ['fg', 'Conditional'],
	--   \ 'pointer':    ['fg', 'Exception'],
	--   \ 'marker':     ['fg', 'Keyword'],
	--   \ 'spinner':    ['fg', 'Label'],
	--   \ 'header':     ['fg', 'Comment'] }
	-- ]])
 --    end,
 --  },
}
