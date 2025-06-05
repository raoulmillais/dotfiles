local map = require('core.map')

local M = {}

local default_keymap_opts = { noremap = true, silent = true }

M.register_normal_keymaps = function(keymaps)
  for _, km in pairs(keymaps) do
    local lhs, rhs, o = unpack(km)
    M.merge(o, default_keymap_opts)
    map.n(lhs, rhs, o)
  end
end

--- merge is a short cut for vim.tbl_deep_extend with 'force' behaviour
M.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

return M
