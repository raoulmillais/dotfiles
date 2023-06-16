local lua_ls = {}

lua_ls.settings = {}

lua_ls.settings.Lua = {
    diagnostics = {
      globals = {
        'vim', 'bit', 'imap', 'nmap', 'cmap', 'setbuf', 'nmap_buf'
      }
    },
    workspace = {
      checkThirdParty = false
    }
  }

return lua_ls

