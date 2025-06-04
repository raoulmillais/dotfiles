local c = require('core')

return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-lua/plenary.nvim'
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
      local themes = require('telescope.themes')
      local merged_opts = c.merge(o, {
        extensions = {
          ["ui-select"] = {
            themes.get_dropdown{}
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.setup(merged_opts)
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      local keymaps = require('config.keymaps')
      c.register_normal_keymaps(keymaps.telescope)
    end
  },
}
