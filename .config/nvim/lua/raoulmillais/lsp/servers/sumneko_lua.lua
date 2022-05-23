local M = {}

M.settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim', 'bit', 'imap', 'nmap', 'cmap', 'setbuf', 'nmap_buf'  }
    }
  }
}

return M

