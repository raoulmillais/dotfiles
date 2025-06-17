local p = require('core.patterns')

local number, whitespace, eof, eol = p.number, p.whitespace, p.eof, p.eol
local addr, addr_offset = p.addr, p.addr_offset
local relative_path, absolute_path = p.relative_path, p.absolute_path
local P = vim.lpeg.P

-- addresses in curlies are structs/slices/interfaces with the internal
-- addresses of the fields
local rr = P("{") * addr * (P(", ") * addr)^0 * P("}")

--[[
--Stack traces
--]]
local sfa = addr + rr
--  ({0xc000281300?, 0xc00011fd98?, 0xf28748?}, {0xc000084f28?, 0xf?, 0x0?})
local stack_arg_list = sfa * (P(", ") * sfa)^0

local path_line_offset = whitespace * absolute_path * P(":") * number * P(" ") *
                          addr_offset * eol
--  goroutine 22 [running]:
local ss = whitespace * P("goroutine ") * number * P(" [running]:") * eol
--The first pair in a stacktrace is always the runtime/debug/Stack()
--  runtime/debug.Stack()
--    /usr/lib/go/src/runtime/debug/stack.go:26 +0x5e
local sp = whitespace * P("runtime/debug.Stack()") * eol *
             path_line_offset
-- stack entries come in pairs
--  github.com/stretchr/testify/suite.failOnPanic(0xc000103500, {0xa76e80, 0xc00017ade0})
--    /home/raoul/go/pkg/mod/github.com/stretchr/testify@v1.10.0/suite/suite.go:89 +0x37
local se = whitespace * relative_path * P("(") * stack_arg_list * P(")") + eol *
             path_line_offset

-- Putting it all together
local st = ss * sp * se^1

local M = {
  runtime_representation = rr,
  stack_function_arg = sfa,
  stack_arg_list = stack_arg_list,
  path_line_offset = path_line_offset,
  stack_start = ss,
  stack_prelude = sp,
  stack_entry = se,
  stack_trace = st
}

return M

