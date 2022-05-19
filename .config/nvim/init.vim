  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vim/vimrc
  lua require('raoulmillais.general')
  lua require('raoulmillais.commands')
  lua require('raoulmillais.autocommands')
  lua require('raoulmillais.keymappings')
