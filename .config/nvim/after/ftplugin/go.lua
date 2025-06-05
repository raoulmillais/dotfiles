-- Don't load this multiple times
if vim.b.ftplugin_loaded then
  return
end
vim.b.ftplugin_loaded = true

local c = require('core')

vim.opt_local.tabstop = 4
vim.cmd("compiler go")

c.autocmd("QuickFixCmdPost", {
  group = c.augroup("open_qf_when_build_fails"),
  pattern = "make", -- pattern is matched against the command being run
  callback = function()
    local qf_is_open = vim.fn.getqflist({winid = 0}).winid > 0
    -- Only open if there are errors and quickfix window isn't already open
    -- The `getqflist` function is weird it does completely different things
    -- depending on its `{what}` argument see `:h getqflist-examples`
    if #vim.fn.getqflist() > 0 and not qf_is_open then
      vim.cmd("copen")
    elseif qf_is_open then
      -- close it if the build succeeded and it was open
      vim.cmd("cclose")
    end
  end,
  desc = "Auto-open quickfix when the build fails"
})
