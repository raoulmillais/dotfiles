return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Load this very early
    opts = {
      contrast = 'hard',
      -- Still gruvbox but less distracting
      overrides = {
        FoldColumn = { bg = "#1d2021" }, -- same as Normal background
        SignColumn = { bg = "#1d2021" }, -- same as Normal background
        Directory = { bg = "#0f1112" }, -- same as Normal background
        DiagnosticSignError = { fg = "#cc241d", bg = "#1d2021" }, -- red
        DiagnosticSignWarn = { fg = "#d79921", bg = "#1d2021" }, -- yellow
        DiagnosticSignInfo = { fg = "#689d6a", bg = "#1d2021" }, -- aqua
        DiagnosticSignHint = { bg = "#1d2021" }, -- normal text color and bg
        ColorColumn = { bg = "#282828" }, -- darkest bg apart from Normal
        CursorLine = { bg = "#282828" }, -- darkest bg apart from Normal
        CursorLineNr = { bg = "#282828" }, -- darkest bg apart from Normal
        NormalFloat = { bg = '#1d2021' }, -- same as Normal background
        StatusLine = { fg = '#458588', bg = '#1d2021' }, --blue in normal mode
        StatusLineNC = { fg = '#665c54', bg = '#1d2021' }, -- gray without focus
        Comment = { fg = '#504945' }, -- darker but still legible
        -- orange to match the status line in insert mode
        ModeMsg = { fg= '#ffaf00', bold = true },
        -- much less alarming error messages
        ErrorMsg = { fg = '#cc241d', bg = "#1d2021", bold = false },
      }
    },
    init = function ()
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
