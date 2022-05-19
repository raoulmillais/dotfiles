  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  lua require('raoulmillais.plug')
  lua require('raoulmillais.general')
  lua require('raoulmillais.commands')
  lua require('raoulmillais.autocommands')
  lua require('raoulmillais.keymappings')
  lua require('raoulmillais.plugins')
