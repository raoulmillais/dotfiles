local M = {}

M.setup = function()
  local luasnip = require("luasnip")

  luasnip.snippets = require("luasnip-snippets").load_snippets()
end

return M
