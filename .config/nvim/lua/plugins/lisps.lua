return {
  {
    'eraserhd/parinfer-rust',
    build = 'cargo build --release'
  },
  {
    'guns/vim-sexp', ft = { 'clojure', 'fennel' }
  },
  {
    'tpope/vim-sexp-mappings-for-regular-people', ft = { 'clojure', 'fennel' }
  },
  { 'Olical/conjure' },
  { 'Olical/nfnl' },
  { 'radenling/vim-dispatch-neovim' },
  {
    'clojure-vim/vim-jack-in',
    dependencies = {
      'radenling/vim-dispatch-neovim'
    }
  },
}
