
local P, R, S = vim.lpeg.P, vim.lpeg.R, vim.lpeg.S

local M = {}

M.number = R("09")^1
--[[
--Whitespace and terminals
--]]
M.whitespace = P(" ")^0
M.eof = P(-1)
M.eol = P("\r\n") + P("\r") + P("\n")

--[[
--Unix paths
--]]

-- Valid characters in a path segment (excluding / which is separator)
-- Allow alphanumeric, dots, dashes, underscores, spaces, and other common filename chars
M.unix_path_char = R("az", "AZ", "09") + S(".-_ ~()[]{}!@#$%^&+=,;")
M.seg = M.unix_path_char^1
M.sep = P("/")

M.seq_of_segs = M.seg * (M.sep * M.seg)^0 * M.sep^-1
M.absolute_path = M.sep * M.seq_of_segs^-1
M.relative_path = M.seq_of_segs
M.unix_path = M.absolute_path + M.relative_path

--[[
--Memory Addresses
--]]
-- traailing question mark when the go runtime isnt sure about the address
M.addr =  P("0x") * R("af", "09")^1 * P("?")^-1
M.addr_offset = P("+") * M.addr

return M
