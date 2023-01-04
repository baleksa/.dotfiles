if vim.b.did_my_after_ftplugin then
	return
end
vim.b.did_my_after_ftplugin = true

vim.opt_local.spell = true
vim.opt_local.spelllang = { "sr", "en_us" }

