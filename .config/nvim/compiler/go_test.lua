-- compiler/go_test.lua: Neovim compiler file for Go tests.
--
-- This compiler is designed to parse `go test -v` output and populate
-- the quickfix list with test failures. It filters out passed tests and
-- external dependencies.

if vim.g.current_compiler then
  return
end
vim.g.current_compiler = "go_test"

vim.opt_local.makeprg = "go test -v ./..."

-- errorformat for parsing go test -v output
-- Only captures test failures with absolute paths from stack traces
vim.opt_local.errorformat = {
  [[%-G=== RUN%.%#]],                            -- Ignore RUN lines
  [[%-G%*\s/go/pkg/mod/%.%#]],                   -- Ignore external deps (/go/pkg/mod/...)
  [[%-G%*\s/usr/lib/go/%.%#]],                   -- Ignore stdlib (/usr/lib/go/...)
  [[%-G%*\s/home/%.%#/go/pkg/mod/%.%#]],         -- Ignore external deps in home dir
  [[%-G%*\s%.%#pkg/mod/%.%#]],                   -- Ignore any pkg/mod paths
  [[%I%*\s%f:%l: %m]],                           -- Info: error message (no navigation)
  [[%E%*\s%f:%l +%.%#]],                         -- Error: first stack trace line (navigable)
  [[%-G%*\s%.%#:\d\+ +%.%#]],                      -- Ignore: subsequent stack trace lines
  [[%-G%*\s%.%#]],                               -- Ignore other indented content
  [[%-G--- FAIL: %m]],                           -- Ignore FAIL lines
  [[%-G--- PASS%.%#]],                           -- Ignore PASS lines
  [[%-GFAIL%*\s%*\S%*\s%.%#]],                   -- Ignore final "FAIL package timing" line
  [[%-GFAIL$]],                                  -- Ignore standalone "FAIL"
  [[%-G%.%#]]                                    -- Ignore everything else
}

-- vim: sw=2 ts=2 et
