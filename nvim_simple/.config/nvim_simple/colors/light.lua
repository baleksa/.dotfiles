-- Light mode colorscheme
vim.cmd.runtime("colors/acme.vim")
vim.cmd([[highlight Normal guifg=#242424]])
vim.cmd([[highlight Comment gui=italic cterm=italic]])
vim.cmd([[highlight Keyword gui=bold cterm=bold]])
vim.cmd([[highlight Statement gui=bold cterm=bold]])
vim.cmd([[highlight Identifier gui=NONE cterm=NONE]])
vim.cmd([[highlight Function guifg=fg  gui=NONE cterm=NONE]])
vim.cmd(
  [[highlight Constant gui=NONE cterm=NONE ctermfg=2 guifg=NvimDarkGreen]]
)
