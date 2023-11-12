local M = {}

function M.setup()
  vim.api.nvim_create_autocmd(
    "FileType",
    { pattern = "netrw", command = "setl bufhidden=delete" }
  )
  vim.g.netrw_winsize = 25
  vim.g.netrw_banner = 0
  vim.g.netrw_browse_split = 0
  -- vim.keymap.set("n", "-", "<cmd>Explore<cr>")
  --
  -- vim.api.nvim_set_keymap("n", "<leader>dc", ":Lex %:p:h<CR>", { noremap = true, silent = true })
  -- -- Open netrw in the directory of the current file.
  -- vim.api.nvim_set_keymap("n", "<leader>dw", ":Lexplore<CR>", { noremap = true, silent = true })
  --
  -- vim.api.nvim_create_autocmd("Filetype", {
  -- 	pattern = "netrw",
  -- 	desc = "Better mappings for netrw",
  -- 	callback = function()
  -- 		local bind = function(lhs, rhs)
  -- 			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
  -- 		end
  --
  -- 		-- edit new file
  -- 		bind("a", "%")
  -- 		-- edit file, open dir
  -- 		bind("l", "<CR>")
  -- 		-- rename file
  -- 		bind("r", "R")
  -- 	end,
  -- })
  -- require("netrw").setup({
  -- 	-- Put your configuration here, or leave the object empty to take the default
  -- 	-- configuration.
  -- 	-- icons = {
  -- 	-- 	symlink = "", -- Symlink icon (directory and file)
  -- 	-- 	directory = "", -- Directory icon
  -- 	-- 	file = "", -- File icon
  -- 	-- },
  -- 	use_devicons = true, -- Uses nvim-web-devicons if true, otherwise use the file icon specified above
  -- 	mappings = {
  -- 		-- ["p"] = function(payload)
  -- 		-- Payload is an object describing the node under the cursor, the object
  -- 		-- has the following keys:
  -- 		-- - dir: the current netrw directory (vim.b.netrw_curdir)
  -- 		-- - node: the name of the file or directory under the cursor
  -- 		-- - link: the referenced file if the node under the cursor is a symlink
  -- 		-- - extension: the file extension if the node under the cursor is a file
  -- 		-- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
  -- 		-- 	print(vim.inspect(payload))
  -- 		-- end,
  -- 		["."] = function(payload)
  -- 			vim.fn.feedkeys(
  -- 				": "
  -- 					.. payload.dir
  -- 					.. "/"
  -- 					.. payload.node
  -- 					.. vim.api.nvim_replace_termcodes("<C-b>", true, true, true)
  -- 			)
  -- 		end,
  -- 	},
  -- })
end

return M
