-- Dark mode colorscheme
vim.cmd.runtime("colors/quiet.vim")
vim.cmd([[highlight Comment gui=italic cterm=italic]])
vim.cmd([[highlight Keyword gui=bold cterm=bold]])
vim.cmd([[highlight Statement gui=bold cterm=bold]])
vim.cmd([[highlight Identifier gui=NONE cterm=NONE]])
vim.cmd([[highlight Function guifg=  gui=NONE cterm=NONE]])
vim.cmd([[highlight Constant guifg=#999999]])
vim.cmd([[highlight NormalFloat guibg=#333333]])
