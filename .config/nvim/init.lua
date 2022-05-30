local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify(impatient)
end

if require('raoulmillais.packer-install').ensure() then
  return
end

require 'raoulmillais.global'
require 'raoulmillais.packer'
require 'raoulmillais.general'
require 'raoulmillais.signs'
require 'raoulmillais.commands'
require 'raoulmillais.autocommands'
require 'raoulmillais.keymappings'
require 'raoulmillais.plugins'

require 'raoulmillais.orgmode'
require 'raoulmillais.snippets'
require 'raoulmillais.treesitter'
require 'raoulmillais.cmp'
require 'raoulmillais.lsp'
require 'raoulmillais.telescope'
