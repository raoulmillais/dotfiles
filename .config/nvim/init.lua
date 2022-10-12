local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify(impatient)
end

if require('raoulmillais.packer-install').ensure() then
  -- packer was just installed - restart required
  return
end

-- MAIN ENTRY POINT
--
-- 'require' files which perform custom configuration in a specific order
-- should go here - they are split up for easier maintenance :)
--
-- Note: Do not require files which are modules - I.E. modules that return
-- something (hopefully a table if module conventions are followed)
require 'raoulmillais.global'
require 'raoulmillais.packer'
require 'raoulmillais.general'
require 'raoulmillais.signs'
require 'raoulmillais.autocommands'
require 'raoulmillais.keymappings'
require 'raoulmillais.plugins'

require 'raoulmillais.orgmode'
require 'raoulmillais.treesitter'
require 'raoulmillais.diagnostics'
require 'raoulmillais.cmp'
require 'raoulmillais.lsp'
require 'raoulmillais.telescope'
