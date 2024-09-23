-- BUNDLED PLUGINS {{{1
-- Use the matchit macro to enable switching between open close tags and
-- if/elsif/else/end with %
vim.cmd[[runtime macros/matchit.vim]]
vim.cmd[[runtime ftplugin/man.vim]]  -- Enable viewing man pages
-- }}}
--
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  -- Should not get here - lazy-install.lua should run first
  print("Lazy not installed")
  return
end

-- Example using a list of specs with the default options
vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "," -- Same for `maplocalleader`

lazy.setup({
  { import = "plugins" },
  'ellisonleao/gruvbox.nvim',
  {
    'echasnovski/mini.pairs',
    version = '*'
  },
  'gpanders/editorconfig.nvim',
  'windwp/nvim-ts-autotag',


  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'sar/schemastore.nvim',
  'folke/neodev.nvim',
  'simrat39/rust-tools.nvim',
  'MunifTanjim/prettier.nvim',
  'lewis6991/gitsigns.nvim',
  'nanotee/luv-vimdocs',
  'milisims/nvim-luaref',
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  'nvim-telescope/telescope-ui-select.nvim',
  'benmills/vimux',
  'benmills/vimux-golang',
  'christoomey/vim-tmux-navigator',
  'mhinz/vim-startify',
  'othree/yajs.vim',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'jremmen/vim-ripgrep',
  'vim-scripts/scratch.vim',
  'vifm/vifm.vim',
  { 'eraserhd/parinfer-rust', build = 'cargo build --release' },
  {'guns/vim-sexp', ft = { 'clojure' } },
  { 'tpope/vim-sexp-mappings-for-regular-people', ft = { 'clojure' } },
  'Olical/conjure',
  'Olical/nfnl',
  'clojure-vim/vim-jack-in',
  'radenling/vim-dispatch-neovim',
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
})
