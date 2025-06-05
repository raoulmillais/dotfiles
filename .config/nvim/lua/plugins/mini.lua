local c = require('core')
local map = require('core.map')

return {
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
    },
    config = function(_, opts)
      require('mini.pairs').setup(opts)
      -- Disable mini.pairs when going from visual block or visual into insert
      c.autocmd("ModeChanged", {
        group = "MiniPairs", -- same as the group in `mini.pairs`
        pattern = { "V:i", "\22:i" },
        callback = function()
            vim.b.minipairs_disable = true
        end
      })
      -- Re-enable mini.pairs if it was disabled when leaving insert mode
      c.autocmd("ModeChanged", {
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
      map.x('S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

      -- Make special mapping for "add surrounding for line"
      map.n('yss', 'ys_', { remap = true })
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
}
