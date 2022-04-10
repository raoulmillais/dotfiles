# .zshenv 
#
# This file is always sourced so should contain env vars that need to be
# changed frequently and should be set for non-interactive sessions.
export EDITOR=vim
export VISUAL=vim

# Disallow duplicate entries in the path
typeset -U path

# PL specific user bin paths
path+=("./node_modules/.bin")
path+=("$HOME/go/bin")
path+=("$HOME/.cargo/bin")

# Precompiled binaries downloaded from the web and my own scripts
path+=("$HOME/bin")
path+=("$HOME/.local/bin")

path+=("$HOME/.vim/plugged/vim-iced/bin")
path+=("$HOME/.npm-global/bin")
export PATH
