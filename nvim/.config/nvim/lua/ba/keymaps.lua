-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true } -- Opts for a lots of mappings

-- Easier window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.api.nvim_set_keymap("n", "<C-Up>", ":resize +2<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- Move text up and down
vim.api.nvim_set_keymap("v", "<A-j>", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("v", "p", '"_dP', opts)

-- Move text up and down
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

local term_opts = { silent = true }
-- Better terminal navigation
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

vim.api.nvim_set_keymap("n", "<leader><space>", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sf",
	[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sb",
	[[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
	opts
)
vim.api.nvim_set_keymap("n", "<leader>sh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap("n", "<leader>st", [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
vim.api.nvim_set_keymap("n", "<leader>sd", [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
vim.api.nvim_set_keymap("n", "<leader>sp", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
-- vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
vim.api.nvim_set_keymap("n", "<leader>so", [[<cmd>lua require('telescope.builtin').current_buffer_tags()>]], opts)
vim.api.nvim_set_keymap("n", "<leader>?", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
