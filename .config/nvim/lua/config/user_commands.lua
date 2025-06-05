local usercmd = require('core.nvim.usercmd')

usercmd.create('DiagnosticsToggle', function()
    local enabled = vim.diagnostic.is_enabled()
    if enabled then
      vim.diagnostic.enable(false)
    else
      vim.diagnostic.enable()
    end
  end, {})
