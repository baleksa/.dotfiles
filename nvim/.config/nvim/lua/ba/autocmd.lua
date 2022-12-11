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
