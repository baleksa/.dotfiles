local neogit = require("neogit")

-- buffers
vim.keymap.set("n", "[b", ":bprev<cr>")
vim.keymap.set("n", "]b", ":bnext<cr>")

-- files
vim.keymap.set("n", "<leader>fs", ":grep<space>")

-- tabs
vim.keymap.set("n", "[t", ":tabprev<cr>")
vim.keymap.set("n", "]t", ":tabnext<cr>")
vim.keymap.set("n", "<leader>tn", ":tabnew<cr>")
vim.keymap.set("n", "<leader>tf", ":tabfind")

-- quickfix
vim.keymap.set("n", "[q", ":cprev<cr>")
vim.keymap.set("n", "]q", ":cnext<cr>")

-- completion
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")

-- git
vim.keymap.set("n", "<Leader>gg", neogit.open)

vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>")

-- window navigation
vim.keymap.set("n", "<A-h>", "<C-w>h", {})
vim.keymap.set("n", "<A-j>", "<C-w>j", {})
vim.keymap.set("n", "<A-k>", "<C-w>k", {})
vim.keymap.set("n", "<A-l>", "<C-w>l", {})

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", {})
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", {})
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", {})

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", {})
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", {})
vim.keymap.set("v", "p", '"_dP', {})

-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", {})
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", {})
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", {})
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", {})

-- Better terminal navigation
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h", {})
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j", {})
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k", {})
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l", {})
vim.keymap.set("t", "<A-o>", "<C-\\><C-n><C-o>", {})
vim.keymap.set("t", "<A-n>", "<C-\\><C-n>", {})
vim.keymap.set("t", "<A-6>", "<C-\\><C-n><C-6>", {})
