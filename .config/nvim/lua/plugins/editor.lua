local c = require('core')

return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Load this very early
    opts = {
      contrast = 'hard',
    },
    config = function (_, opts)
      local merged = c.merge(opts, { overrides = require('config.colors') })
      require('gruvbox').setup(merged)
      vim.cmd.colorscheme 'gruvbox'
    end
  },
  { 'jremmen/vim-ripgrep' },
  { 'vim-scripts/scratch.vim' },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'hyper',
      config = {
        mru = { limit = 15 },
        shortcut = {},
        week_header = {
         enable = true,
        },
        footer = { '' },
        project = { enable = false }
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      -- Use slimmer guidelines and we have list/listchars set so we
      -- have to set tab_char or the guides won't show (ibl uses the
      -- lcs-tab setting)
      indent = {
        char = "│",
        tab_char = "│",
      },
      exclude = {
        filetypes = { "dashboard" },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end
  }
}
