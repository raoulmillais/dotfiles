local c = require('core')
local keymaps = require('config.keymaps')

c.register_normal_keymaps(keymaps.diagnostics)

vim.diagnostic.config({
  virtual_text = false, -- We show diagnostics in a float -- see autocmds.lua
  float = {
    header = "",
    source = true,
    focusable = false,
    anchor_bias = "above",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    }
  }
})
