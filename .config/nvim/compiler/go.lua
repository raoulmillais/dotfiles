-- The go build errorformat was taken from https://github.com/fatih/vim-go/blob/787342da47bc5fe6fa88e9d65842c6a0a6304700/compiler/go.vim
--
-- Copyright notice from the original source:
--
-- Copyright 2013 The Go Authors. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.
--
-- compiler/go.lua: Neovim compiler file for Go.

if vim.g.current_compiler then
  return
end
vim.g.current_compiler = "go"

if vim.fn.filereadable("makefile") == 1 or vim.fn.filereadable("Makefile") == 1 then
  vim.opt_local.makeprg = "make"
else
  vim.opt_local.makeprg = "go build"
end

-- errorformat for parsing go build output and populating the quickfix list
vim.opt_local.errorformat = {
  "%-G#\\ %.%#",                                 -- Ignore lines beginning with '#' ('# command-line-arguments' line sometimes appears?)
  "%-G%.%#panic:\\ %m",                          -- Ignore lines containing 'panic: message'
  "%Ecan\\'t\\ load\\ package:\\ %m",            -- Start of multiline error string is 'can\'t load package'
  "%A%\\%%(%[%^:]%\\+:\\ %\\)%\\?%f:%l:%c:\\ %m", -- Start of multiline unspecified string is 'filename:linenumber:columnnumber:'
  "%A%\\%%(%[%^:]%\\+:\\ %\\)%\\?%f:%l:\\ %m",    -- Start of multiline unspecified string is 'filename:linenumber:'
  "%C%*\\s%m",                                   -- Continuation of multiline error message is indented
  "%-G%.%#"                                      -- All lines not matching any of the above patterns are ignored
}

-- vim: sw=2 ts=2 et
