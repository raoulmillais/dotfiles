-- Don't load this multiple times
if vim.b.ftplugin_loaded then
  return
end
vim.b.ftplugin_loaded = true

local augroup = require('core.nvim.augroup')
local autocmd = require('core.nvim.autocmd')
local test = require('core.lang.go.testparser')

vim.opt_local.tabstop = 4
vim.cmd("compiler go")

autocmd.create("QuickFixCmdPost", {
  group = augroup.create("open_qf_when_build_fails"),
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

--[[
--  GoTest with population of the quickfix
--]]
--

-- Create buffer-local command for testing
vim.api.nvim_buf_create_user_command(0, "GoTest", test.go_test_quickfix, {
  desc = "Run Go tests and populate quickfix with failures"
})
