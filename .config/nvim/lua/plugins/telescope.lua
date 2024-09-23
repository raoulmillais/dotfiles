return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
}
