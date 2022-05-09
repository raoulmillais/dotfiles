vim9script

# AUTO-INSTALL VIM-PLUG {{{1
###############################################################################
# Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

# Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
# }}}

# VIM-PLUG {{{1
###############################################################################
call plug#begin('~/.vim/plugged')

Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-prettier'
Plug 'neoclide/coc-eslint'
Plug 'othree/yajs.vim'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-scripts/scratch.vim'
Plug 'vifm/vifm.vim'
Plug 'cespare/vim-toml'
Plug 'eraserhd/parinfer-rust',                     {'for': 'clojure'}
Plug 'guns/vim-sexp',                              {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'liquidz/vim-iced',                           {'for': 'clojure'}
Plug 'liquidz/vim-iced-coc-source',                {'for': 'clojure'}
# TODO: move from NERDTree to fern instead of having both?  NERDTree plays nice 
# with devicons and I know all the mappings but the iced debugger wants fern
Plug 'lambdalisue/fern.vim' 
Plug 'liquidz/vim-iced-fern-debugger',             {'for': 'clojure'}
# Must come last
Plug 'ryanoasis/vim-devicons'

call plug#end()
# }}}

# BUNDLED PLUGINS {{{1
###############################################################################
# Use the matchit macro to enable switching between open close tags and
# if/elsif/else/end with %
packadd! matchit
runtime  ftplugin/man.vim  # Enable viewing man pages
# }}}
