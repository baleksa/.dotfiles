vim.api.nvim_create_autocmd("FileType", { pattern = "netrw", command = "setl bufhidden=delete" })
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.fastbrowse = 0
vim.g.netrw_browse_split = 0
vim.keymap.set("n", "-", "<cmd>Explore<cr>")
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
