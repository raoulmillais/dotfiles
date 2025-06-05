local M = {}

M.i = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

M.n = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

M.c = function(lhs, rhs, opts)
  vim.keymap.set("c", lhs, rhs, opts)
end

M.x = function(lhs, rhs, opts)
  vim.keymap.set("x", lhs, rhs, opts)
end

M.buf = {}

M.buf.i = function(bufnr, lhs, rhs, o)
  vim.api.nvim_buf_set_keymap(bufnr, "i", lhs, rhs, o)
end

M.buf.n = function(bufnr, lhs, rhs, o)
  vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, o)
end

M.buf.c = function(bufnr, lhs, rhs, o)
  vim.api.nvim_buf_set_keymap(bufnr, "c", lhs, rhs, o)
end

return M
