vim.opt.colorcolumn = "80"
-- vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.tabstop = 8
-- vim.opt.shiftwidth = 8
-- vim.opt.expandtab = true
vim.opt.autoindent = true

-- vim.opt.spelllang = "en_us,rs"
-- vim.opt.spelloptions = "camel"
-- vim.opt.spell = false -- Spellcheck

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

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", { pattern = "*", callback = function() vim.highlight.on_yank{higroup="IncSearch", timeout=150, on_visual=false} end , group = vim.api.nvim_create_augroup("highlight_yank", {})})

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.opt.laststatus = 3 -- Set global statusbar.
