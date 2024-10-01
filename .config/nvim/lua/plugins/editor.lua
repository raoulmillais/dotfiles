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
      vim.api.nvim_set_hl(0, 'Comment', {italic = true})
    end
  },
  --[[
  --  All the mini.nvim plugins provide modern-treesitter aware and undo-enabled
  --  versions of some classic plugins (mostly by tpope). They also respect
  --  `v:count` unlike the legacy plugins
  --]]
  -- Enhanced a/i (around/inside) text objects
  {
    'echasnovski/mini.ai',
    version = '*',
    event = 'VeryLazy'
  },
  -- Auto-balance parentheses
  {
    'echasnovski/mini.pairs',
    version = '*',
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  -- Add/delete/replace/find/highlight surrounding parens/quotes/etc
  {
    'echasnovski/mini.surround',
    version = '*',
    event = 'VeryLazy',
    opts= {}
  },
  -- Cycle through targets with square bracket keymaps - (like vim-unimpaired)
  {
    'echasnovski/mini.bracketed',
    version = '*',
    event = 'VeryLazy',
    opts= {}
  },
  -- Interactively align/split/justify/merge code and text into columns
  {
    'echasnovski/mini.align',
    version = '*',
    event = 'VeryLazy',
    opts= {}
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
  }
}
