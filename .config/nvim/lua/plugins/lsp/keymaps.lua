local c = require('core')
local keymappings = {}

local opts = { noremap = true, silent = true }

keymappings.on_attach = function(_, bufnr)
  local keymaps = require('config.keymaps')
  for _, km in pairs(keymaps.lsp) do
    local lhs, rhs, o = unpack(km)
    c.merge(o, opts)
    c.nmap_buf(bufnr, lhs, rhs, o)
  end
end

return keymappings
