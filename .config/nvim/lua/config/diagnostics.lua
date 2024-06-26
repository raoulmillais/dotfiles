local signs = require('config.config').signs

local opts = { noremap = true, silent = true }

nmap("<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- Use a float instead of virtual text for diagnostics
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
