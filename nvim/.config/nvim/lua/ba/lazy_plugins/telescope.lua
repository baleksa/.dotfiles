local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-dap.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}
function M.config()
  require("telescope").setup({
    -- 	defaults = {
    -- 		mappings = {
    -- 			i = {
    -- 				["<C-u>"] = false,
    -- 				["<C-d>"] = false,
    -- 			},
    -- 		},
    -- 	},
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
    },
    extensions = {},
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("dap")

  -- vim.keymap.set("n", "<leader><space>", function()
  -- 	require("telescope.builtin").buffers()
  -- end, { silent = true, desc = "Search opened buffers" })
  -- vim.keymap.set("n", "<leader>sf", function()
  -- 	require("telescope.builtin").find_files({ previewer = false })
  -- end, { silent = true, desc = "Search files in cwd" })
  -- vim.keymap.set("n", "<leader>sb", function()
  -- 	require("telescope.builtin").current_buffer_fuzzy_find()
  -- end, { silent = true, desc = "Fuzzy search current buffer" })
  -- vim.keymap.set("n", "<leader>sh", function()
  -- 	require("telescope.builtin").help_tags()
  -- end, { silent = true, desc = "Search help documentation" })
  -- vim.keymap.set("n", "<leader>st", function()
  -- 	require("telescope.builtin").tags()
  -- end, { silent = true, desc = "Search tags" })
  -- vim.keymap.set("n", "<leader>sd", function()
  -- 	require("telescope.builtin").grep_string()
  -- end, { silent = true, desc = "Search files in cwd for word under cursor" })
  -- vim.keymap.set("n", "<leader>sg", function()
  -- 	require("telescope.builtin").live_grep()
  -- end, { silent = true, desc = "Live grep" })
  -- vim.keymap.set("n", "<leader>so", function()
  -- 	require("telescope.builtin").current_buffer_tags()
  -- end, { silent = true, desc = "Search current buffer tags" })
  -- vim.keymap.set("n", "<leader>?", function()
  -- 	require("telescope.builtin").oldfiles()
  -- end, { silent = true, desc = "Search previously opened files" })
  vim.keymap.set("n", "<leader>cc", function()
    require("telescope.builtin").colorscheme()
  end, { silent = true, desc = "Search previously opened files" })
  -- WhichKey has builtin mapping for 'z='
  -- vim.keymap.set("n", "z=", function()
  -- 	require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
  -- end, { desc = "Spelling Suggestions" })
end

return M
