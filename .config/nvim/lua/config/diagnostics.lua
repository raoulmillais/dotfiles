local c = require('core')

local opts = { noremap = true, silent = true }

c.nmap("<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
c.nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
c.nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
c.nmap("<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    }
  }
})

-- Use a float instead of virtual text for diagnostics
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
