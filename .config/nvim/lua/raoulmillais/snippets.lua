local M = {}

M.setup = function()
  local luasnip = require("luasnip")

  -- be sure to load this first since it overwrites the snippets table.
  luasnip.snippets = require("luasnip-snippets").load_snippets()
end

return M
