local M = {}

M.imap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

M.nmap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

M.cmap = function(lhs, rhs, opts)
  vim.keymap.set("c", lhs, rhs, opts)
end

M.nmap_buf = function(bufnr, lhs, rhs, o)
  vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, o)
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup("raoulmillais_" .. name, { clear = true })
end

--- merge is a short cut for vim.tbl_deep_extend with 'force' behaviour
M.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

return M
