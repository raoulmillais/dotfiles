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
      modes = { insert = true, command = false, terminal = false },
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
    config = function(_, opts)
      require('mini.pairs').setup(opts)
      -- Disable mini.pairs when going from visual block or visual into insert
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = "MiniPairs", -- same as the group in `mini.pairs`
        pattern = { "V:i", "\22:i" },
        callback = function()
            vim.b.minipairs_disable = true
        end
      })
      -- Re-enable mini.pairs if it was disabled when leaving insert mode
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = "MiniPairs", -- same as the group in `mini.pairs`
        pattern = "i:*",
        callback = function()
          if vim.b.minipairs_disable == true then
            vim.b.minipairs_disable = false
          end
        end
      })
    end,
  },
  -- Add/delete/replace/find/highlight surrounding parens/quotes/etc
  {
    'echasnovski/mini.surround',
    version = '*',
    event = 'VeryLazy',
    opts= {
      -- make mini.surround behave like tpope/surround.vim
      mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',
      },
      search_method = 'cover_or_next',
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)

      -- More keymap changes to make mini.surround act like tpope/surround.vim
      -- See :h mini.surround
      --
      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del('x', 'ys')
      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

      -- Make special mapping for "add surrounding for line"
      vim.keymap.set('n', 'yss', 'ys_', { remap = true })
    end
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
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  }
}
