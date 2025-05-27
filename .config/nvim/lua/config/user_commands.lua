vim.api.nvim_create_user_command(
  'DiagnosticsToggle',
  function()
    local enabled = vim.diagnostic.is_enabled()
    if enabled then
      vim.diagnostic.enable(false)
    else
      vim.diagnostic.enable()
    end
  end,
  {}
)
