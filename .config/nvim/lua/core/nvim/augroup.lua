local M = {}
local prefix = "raoulmillais_"

M.create = function(name)
  return vim.api.nvim_create_augroup(prefix.. name, { clear = true })
end

M.del = function(name)
  return vim.api.nvim_del_augroup_by_name(prefix.. name)
end

return M
