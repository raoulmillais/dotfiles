local c = require('core')

return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
        -- Until plenary has the fix taking into account the new winborder
        -- setting we have to use the fork with the pending PR
        -- https://github.com/nvim-telescope/telescope.nvim/issues/3436
      { 'emmanueltouzery/plenary.nvim', branch = 'winborder' }
    },
    opts = {
      color_devicons = false,
      defaults = {
        winblend = 0,
      },
      scroll_strategy = "cycle",
    },
    config = function(_, o)
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local themes = require('telescope.themes')

      local simple_dropdown = {
        theme = "dropdown",
        previewer = false,
      }
      local overrides = {
        defaults = {
          -- Add the same mappints as blink menu and the 'wildmenu'
          mappings = {
            i = {
              ['<C-y>'] = actions.select_default,
              ['<C-e>'] = actions.close
            },
            n = {
              ['<C-y>'] = actions.select_default,
              ['<C-e>'] = actions.close
            }
          }
        },
        pickers = {
          find_files = simple_dropdown,
          git_files = simple_dropdown,
        },
        extensions = {
          ["ui-select"] = {
            -- there seems to be no way to override the
            themes.get_cursor(),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }

      telescope.setup(c.merge(o, overrides))

      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      local keymaps = require('config.keymaps')
      c.register_normal_keymaps(keymaps.telescope)
    end
  },
}
