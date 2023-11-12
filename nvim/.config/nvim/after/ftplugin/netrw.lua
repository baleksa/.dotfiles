if vim.b.did_after_ftplugin then
  return
end
vim.b.did_after_ftplugin = true

local bind = function(lhs, rhs, opts)
  vim.keymap.set(
    "n",
    lhs,
    rhs,
    vim.tbl_deep_extend("force", { buffer = true }, opts or {})
  )
end

bind("a", "%", { remap = true })
bind("r", "R", { remap = true })
