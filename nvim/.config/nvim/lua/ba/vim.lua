---
-- Set plain vim options, keymaps and autocommands
---

vim.opt.colorcolumn = "80"
-- vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.tabstop = 8
-- vim.opt.shiftwidth = 8
-- vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 5

-- vim.opt.spelllang = "en_us,rs"
-- vim.opt.spelloptions = "camel"
-- vim.opt.spell = false -- Spellcheck

vim.opt.backup = true
vim.opt.backupdir = vim.env.XDG_STATE_HOME .. "/nvim/backup"

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

vim.opt.termguicolors = true

vim.opt.hlsearch = false -- Set highlight on search
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.rnu = true

vim.opt.mouse = "a" -- Enable mouse mode

vim.opt.breakindent = true -- Enable break indent

vim.opt.undofile = true -- Save undo history

vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true

vim.opt.updatetime = 50 -- Decrease update time

vim.opt.signcolumn = "yes" -- Always show column next to the number column used for git and diagnostics sign

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.o.laststatus = 3 -- Set global statusbar.

-- Don't use this find better solution for changing cwd
-- vim.o.autochdir = true

---
-- Keymaps
---
local opts = { silent = true } -- Opts for a lots of mappings

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Put the cursor at the center after some motions
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Easier +" yanking
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>y", '"+y')
-- and pasting
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

vim.keymap.set("n", "<leader>q", "<cmd>bdelete<cr>")

-- Easier window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", opts)
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

local term_opts = { silent = true }
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

vim.keymap.set("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
---
-- Autocommands
---
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150, on_visual = false })
	end,
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
})
vim.api.nvim_create_autocmd("FileType", { pattern = "c", command = "setlocal noet ts=8 sw=8 tw=80" })
vim.api.nvim_create_autocmd("FileType", { pattern = "h", command = "setlocal noet ts=8 sw=8 tw=80" })
vim.api.nvim_create_autocmd("FileType", { pattern = "cpp", command = "setlocal noet ts=8 sw=8 tw=80" })
vim.api.nvim_create_autocmd("FileType", { pattern = "s", command = "setlocal noet ts=8 sw=8" })
vim.api.nvim_create_autocmd("FileType", { pattern = "go", command = "setlocal noet ts=4 sw=4" })
vim.api.nvim_create_autocmd("FileType", { pattern = "lua", command = "setlocal noet ts=4 sw=4" })
vim.api.nvim_create_autocmd("FileType", { pattern = "sh", command = "setlocal noet ts=8 sw=8" })
vim.api.nvim_create_autocmd("BufRead, BufNewFile", { pattern = "*.js", command = "setlocal et ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "html", command = "setlocal et ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "htmldjango", command = "setlocal et ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "scss", command = "setlocal et ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "yaml", command = "setlocal et ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "markdown", command = "setlocal tw=80 et ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "text", command = "setlocal tw=80" })
vim.api.nvim_create_autocmd("FileType", { pattern = "meson", command = "setlocal noet ts=2 sw=2" })
vim.api.nvim_create_autocmd("FileType", { pattern = "python", command = "setlocal et ts=4 sw=4" })
vim.api.nvim_create_autocmd("FileType", { pattern = "mail", command = "setlocal noautoindent" })
vim.api.nvim_create_autocmd("FileType", { pattern = "gmi", command = "set wrap linebreak" })
vim.api.nvim_create_autocmd(
	"BufRead, BufNewFile",
	{ pattern = "*", command = "if expand('%:t') == 'APKBUILD' | set ft=sh | endif" }
)
vim.api.nvim_create_autocmd(
	"BufRead, BufNewFile",
	{ pattern = "*", command = "if expand('%:t') == 'PKGBUILD' | set ft=sh | endif" }
)
