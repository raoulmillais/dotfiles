vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

-- BUNDLED PLUGINS {{{1
-- Use the matchit macro to enable switching between open close tags and
-- if/elsif/else/end with %
vim.cmd[[runtime macros/matchit.vim]]
vim.cmd[[runtime ftplugin/man.vim]]  -- Enable viewing man pages
-- }}}
--
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  -- Should not get here - packer-install.lua should run first
  print("Packer not installed")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- PACKER {{{1
return require("packer").startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Speed up loading
  use { 'lewis6991/impatient.nvim' }

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'ellisonleao/gruvbox.nvim' }
  -- Utilities
  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'gpanders/editorconfig.nvim' }
  use { 'nvim-orgmode/orgmode' }
  use {
    'lewis6991/spellsitter.nvim',
    enable = true,
    config = function()
      require('spellsitter').setup()
    end
  }
  -- LSP & cmp
  use { 'neovim/nvim-lspconfig' }
  use "j-hui/fidget.nvim"
  use {
    "ericpubu/lsp_codelens_extensions.nvim",
    config = function()
      require("codelens_extensions").setup()
    end,
  }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'hrsh7th/cmp-nvim-lsp-document-symbol' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'molleweide/LuaSnip-snippets.nvim' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'williamboman/nvim-lsp-installer' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'onsails/lspkind.nvim' }
  use { 'sar/schemastore.nvim' }
  use {
    'RishabhRD/nvim-lsputils',
    requires = 'RishabhRD/popfix',
  }
  use { 'folke/lua-dev.nvim' }

  use { 'lewis6991/gitsigns.nvim' }

  use { 'nanotee/luv-vimdocs' }
  use { 'milisims/nvim-luaref' }

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  --
  -- Legacy
  --
  use { 'benmills/vimux' }
  use { 'benmills/vimux-golang' }
  use { 'christoomey/vim-tmux-navigator' }
  use { 'mhinz/vim-startify' }
  use { 'rust-lang/rust.vim' }
  use { 'othree/yajs.vim' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }
  use { 'jremmen/vim-ripgrep' }
  use { 'vim-scripts/scratch.vim' }
  use { 'vifm/vifm.vim' }
  use { 'eraserhd/parinfer-rust', ft = { 'clojure' } }
  use {'guns/vim-sexp', ft = { 'clojure' } }
  use { 'tpope/vim-sexp-mappings-for-regular-people', ft = { 'clojure' } }
  use { 'liquidz/vim-iced', ft = { 'clojure'} }
  use { 'kyazdani42/nvim-web-devicons' }
end)
-- }}}

