local c = require('core')
return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Load this very early
    opts = {
      contrast = 'hard',
    },
    init = function ()
      vim.o.background = "dark" -- Dark colorscheme
      vim.g.gruvbox_italic = 1 -- Alacritty supports italics just fine
      vim.cmd.colorscheme 'gruvbox'
      c.hl(0, 'Comment', {italic = true})
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
