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

require 'config.global'
require 'config.lazy'
require 'config.options'
require 'config.signs'
require 'config.autocommands'
require 'config.keymaps'
require 'config.plugins'

require 'config.treesitter'
require 'config.diagnostics'
require 'config.cmp'
require 'config.lsp'
require 'config.telescope'
