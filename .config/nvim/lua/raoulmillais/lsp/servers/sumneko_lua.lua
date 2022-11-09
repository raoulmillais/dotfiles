local sumneko_lua = {}

sumneko_lua.settings = {}

sumneko_lua.settings.Lua = {
    diagnostics = {
      globals = {
        'vim', 'bit', 'imap', 'nmap', 'cmap', 'setbuf', 'nmap_buf'
      }
    }
  }

return sumneko_lua

