imap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

nmap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

cmap = function(lhs, rhs, opts)
  vim.keymap.set("c", lhs, rhs, opts)
end

set_buf = function(bufnr, name, value)
  vim.api.nvim_buf_set_option(bufnr, name, value)
end

nmap_buf = function(bufnr, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
end

require'nvim-web-devicons'.setup { default = true }
require'nvim-tree'.setup { }
