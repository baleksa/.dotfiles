require("ba.vim")
require("ba.lazy")

if (vim.g.file_explorer == "netrw") then
	require("ba.netrw").config()
end
