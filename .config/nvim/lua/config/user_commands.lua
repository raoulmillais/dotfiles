local usercmd = require('core.nvim.usercmd')

usercmd.create('DiagnosticsToggle', function()
    local enabled = vim.diagnostic.is_enabled()
    if enabled then
      vim.diagnostic.enable(false)
    else
      vim.diagnostic.enable()
    end
  end, {})

  usercmd.create('NeoReplOpen', function()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    local new_win = vim.api.nvim_open_win(0, true, {
      split = 'below',
      height = 20,
    })

    require('neorepl').new{
      lang = 'lua',
      buffer = buf,
      window = win,
    }

    vim.api.nvim_set_option_value('winfixheight', true, { win = new_win })
  end, {})


