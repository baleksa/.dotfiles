vim.g.mkdp_browser = "firefox-wayland" -- Browser which MarkdownPreview will use to show markdown file preview

vim.cmd([[
let g:mkdx#settings     = { 'highlight': { 'enable': 0 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
]])
