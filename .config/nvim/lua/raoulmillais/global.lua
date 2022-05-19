imap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

nmap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

nmap_buf = function(bufnr, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, lhs, rhs, opts)
end

cmap = function(lhs, rhs, opts)
  vim.keymap.set("c", lhs, rhs, opts)
end
