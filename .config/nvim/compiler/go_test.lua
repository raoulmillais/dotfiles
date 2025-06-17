-- compiler/go_test.lua: Neovim compiler file for Go tests.
--
-- This compiler is designed to parse `go test -v` output and populate
-- the quickfix list with test failures. It filters out passed tests and
-- external dependencies.

if vim.g.current_compiler == "go_test" then
  return
end
vim.g.current_compiler = "go_test"

vim.opt_local.makeprg = "go test -v ./..."

-- errorformat for parsing go test -v output
-- Only captures test failures with absolute paths from stack traces
vim.opt_local.errorformat = {
  [[%E=== RUN   %o]],                                    -- Start multiline with test name
  [[%C%*\sError Trace:%*\s%f:%l]],                       -- Capture file:line from Error Trace
  [[%C%*\sMessages:%*\s%m]],                             -- Capture message from Messages line
  [[%C%.%#]],                                            -- Continue other lines
  [[%-Z--- SKIP:.*]],                                    -- End and discard SKIP tests (before FAIL)
  [[%-Z--- PASS:.*]],                                    -- End and discard PASS tests (before FAIL)
  [[%Z--- FAIL:.*]],                                     -- End and keep FAIL tests
  [[panic: %m]],                                         -- Single-line pattern for panic messages
  [[%-G%.%#]]                                            -- Ignore other lines
}
-- vim: sw=2 ts=2 et
