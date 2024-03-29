require("ba.vim")

vim.g.status_line = "cokeline"
vim.g.too_large_file_lnum = 2000
vim.g.file_explorer = "oil"

require("ba.lazy")
require("ba.map")

if vim.g.file_explorer == "netrw" then
  require("ba.netrw").setup()
end

-- nfnl compiled lua
-- I can't find better solution to mix lua and fennel
require("ba.lua")
