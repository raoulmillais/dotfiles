--local ok, impatient = pcall(require, 'impatient')
--if ok then
--  impatient.enable_profile()
--else
--  vim.notify(impatient)
--end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- MAIN ENTRY POINT
--
-- 'require' files which perform custom configuration in a specific order
-- should go here - they are split up for easier maintenance :)
--
-- Note: Do not require files which are modules - I.E. modules that return
-- something (hopefully a table if module conventions are followed)
require 'raoulmillais.global'
require 'raoulmillais.lazy'
require 'raoulmillais.general'
require 'raoulmillais.signs'
require 'raoulmillais.autocommands'
require 'raoulmillais.keymappings'
require 'raoulmillais.plugins'

require 'raoulmillais.treesitter'
require 'raoulmillais.diagnostics'
require 'raoulmillais.cmp'
require 'raoulmillais.lsp'
require 'raoulmillais.telescope'
