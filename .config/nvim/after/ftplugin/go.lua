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
local function go_test_quickfix()
  local original_compiler = vim.g.current_compiler

  vim.cmd("compiler go_test")
  -- Disable any autocmds (there is one to open the qflist) and use the bang
  -- version of make to stop it navigating to the first error before we get
  -- a chance to post-process the qflist (see comment below)
  vim.cmd("noautocmd make!")

  -- Post-process quickfix to work around errorformat limitations:
  -- vim's errorformat cannot create e single entry with the correct path + filename
  -- for each test failure, so I made the errorformat create an info message with
  -- the error messsage and then subsequent error messages with the relevant stack
  -- lines in our code. The info message has a broken navigation links (just the filename).
  -- So I manually clear filename/location data from info entries to make
  -- to prevent them being navigable to a non-exitent empty file.
  local qflist = vim.fn.getqflist()
  for _, entry in ipairs(qflist) do
    if entry.type == 'I' or entry.type == 'i' then
      entry.bufnr = 0
      entry.filename = ""
      entry.lnum = 0
      entry.col = 0
    end
  end

  vim.fn.setqflist(qflist, 'r')

  if original_compiler then
    vim.cmd("compiler " .. original_compiler)
  end
end

-- Create buffer-local command for testing
vim.api.nvim_buf_create_user_command(0, "GoTest", go_test_quickfix, {
  desc = "Run Go tests and populate quickfix with failures"
})
