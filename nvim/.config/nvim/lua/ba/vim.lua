vim.opt.colorcolumn = "80"
-- vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.tabstop = 8
-- vim.opt.shiftwidth = 8
-- vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.spelllang = "en_us,rs"
vim.opt.spelloptions = "camel"
vim.opt.spell = false -- Spellcheck

vim.opt.termguicolors = true -- Pretty much sure this is default but who gives a fuck

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

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

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
-- vim.api.nvim_create_autocmd("FileType", { pattern="tex ", command = "hi Error ctermbg=NONE"})
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
vim.api.nvim_create_autocmd("BufRead, BufNewFile", { pattern = "*/sway/config.d/*", command = "set ft=i3config" })
vim.api.nvim_create_autocmd("BufRead, BufNewFile", { pattern = "*/.config/myenv/*", command = "set ft=sh" })

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.opt.laststatus = 3 -- Set global statusbar.
