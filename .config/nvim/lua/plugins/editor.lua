return {
  'ellisonleao/gruvbox.nvim',
  {
    'echasnovski/mini.pairs',
    version = '*'
  },
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
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
  }
}
