if require("raoulmillais.packer-install").ensure() then
  return
end

require "raoulmillais.global"
require "raoulmillais.packer"
require "raoulmillais.general"
require "raoulmillais.signs"
require "raoulmillais.commands"
require "raoulmillais.autocommands"
require "raoulmillais.keymappings"
require "raoulmillais.plugins"

require "raoulmillais.cmp"
require "raoulmillais.lsp"
require "raoulmillais.telescope"
require "raoulmillais.treesitter"
