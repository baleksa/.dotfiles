require("ba.vim")
require("ba.lazy")
require("ba.colorscheme")

if (vim.g.file_explorer == "netrw") then
	require("ba.netrw").config()
end
