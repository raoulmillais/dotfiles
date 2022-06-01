local lua_dev = require('lua-dev')

local M = {}

M.settings = lua_dev.setup().settings

M.settings.Lua = {
    diagnostics = {
      globals = {
        'vim', 'bit', 'imap', 'nmap', 'cmap', 'setbuf', 'nmap_buf'
      }
    }
  }

return M

