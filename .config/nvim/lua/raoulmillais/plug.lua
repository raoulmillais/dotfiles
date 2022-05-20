vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

-- BUNDLED PLUGINS {{{1
-- Use the matchit macro to enable switching between open close tags and
-- if/elsif/else/end with %
vim.cmd[[runtime macros/matchit.vim]]
vim.cmd[[runtime ftplugin/man.vim]]  -- Enable viewing man pages
-- }}}


-- PACKER {{{1
return require("packer").startup(function(use)
  -- LSP & cmp
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'williamboman/nvim-lsp-installer' }

  use { 'lewis6991/gitsigns.nvim' }

  use { 'nanotee/luv-vimdocs' }
  use { 'milisims/nvim-luaref' }


  --
  -- Legacy
  --
  use { 'benmills/vimux' }
  use { 'benmills/vimux-golang' }
  use { 'christoomey/vim-tmux-navigator' }
  use { 'editorconfig/editorconfig-vim' }
  use { 'elzr/vim-json' }
  use { 'fatih/vim-go' }
  use { 'junegunn/fzf', run = './install --all' }
  use { 'junegunn/fzf.vim' }
  use { 'morhetz/gruvbox' }
  use { 'mhinz/vim-startify' }
  use { 'rust-lang/rust.vim' }
  use { 'othree/yajs.vim' }
  use { 'scrooloose/nerdtree' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-unimpaired' }
  use { 'jremmen/vim-ripgrep' }
  use { 'vim-scripts/scratch.vim' }
  use { 'vifm/vifm.vim' }
  use { 'cespare/vim-toml' }
  use { 'eraserhd/parinfer-rust', ft = { 'clojure' } }
  use {'guns/vim-sexp', ft = { 'clojure' } }
  use { 'tpope/vim-sexp-mappings-for-regular-people', ft = { 'clojure' } }
  use { 'liquidz/vim-iced', ft = { 'clojure'} }
  -- Must come last
  use { 'ryanoasis/vim-devicons' }
end)
-- }}}

