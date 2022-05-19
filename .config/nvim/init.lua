if require "raoulmillais.packer".ensure() then
  return
end

require('raoulmillais.plug')
require('raoulmillais.general')
require('raoulmillais.commands')
require('raoulmillais.autocommands')
require('raoulmillais.keymappings')
require('raoulmillais.plugins')

require('raoulmillais.cmp')
require('raoulmillais.lsp')
