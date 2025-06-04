-- Don't load this multiple times
if vim.b.ftplugin_loaded then
  return
end
vim.b.ftplugin_loaded = true

-- neo-tree interferes so schedule it for
-- the next turn of the event loop
vim.schedule(function()
  vim.opt_local.cursorline = false
end)
