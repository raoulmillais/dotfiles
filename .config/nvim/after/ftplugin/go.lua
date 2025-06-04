-- Don't load this multiple times
if vim.b.ftplugin_loaded then
  return
end
vim.b.ftplugin_loaded = true

vim.opt_local.tabstop = 4
