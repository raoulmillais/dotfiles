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
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  'nvim-treesitter/nvim-treesitter-textobjects',
  'ellisonleao/gruvbox.nvim',
  {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
  },
{ 'echasnovski/mini.pairs', version = '*' },
  'gpanders/editorconfig.nvim',
  "j-hui/fidget.nvim",
  'windwp/nvim-ts-autotag',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lsp-document-symbol',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'onsails/lspkind.nvim',
  'sar/schemastore.nvim',
  'folke/neodev.nvim',
  'simrat39/rust-tools.nvim',
  'MunifTanjim/prettier.nvim',
  'lewis6991/gitsigns.nvim',
  'nanotee/luv-vimdocs',
  'milisims/nvim-luaref',
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
  { "rafamadriz/friendly-snippets" },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
  },
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
  'ryanoasis/vim-devicons',

  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
})
