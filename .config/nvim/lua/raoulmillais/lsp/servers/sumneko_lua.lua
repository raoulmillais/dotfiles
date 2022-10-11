local lua_dev = require('lua-dev')

local sumneko_lua = {}

sumneko_lua.settings = lua_dev.setup().settings

sumneko_lua.settings.Lua = {
    diagnostics = {
      globals = {
        'vim', 'bit', 'imap', 'nmap', 'cmap', 'setbuf', 'nmap_buf'
      }
    }
  }

return sumneko_lua

