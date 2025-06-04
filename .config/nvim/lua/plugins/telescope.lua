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
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        }
      },
      extensions = {
        ["ui-select"] = {
          theme = "dropdown",
          previewer = false,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, o)
      local telescope = require('telescope')
      telescope.setup(o)
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      local keymaps = require('config.keymaps')
      c.register_normal_keymaps(keymaps.telescope)
    end
  },
}
