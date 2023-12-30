require("ba.vim")

vim.g.status_line = "cokeline"
vim.g.too_large_file_lnum = 2000
vim.g.file_explorer = "mini"

require("ba.lazy")
require("ba.map")
-- nfnl compiled lua
-- I can't find better solution to mix lua and fennel
require("ba.lua")
