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

require 'config.lazy'
require 'config.options'
require 'config.signs'
require 'config.autocommands'
require 'config.keymaps'

require 'plugins.treesitter'
require 'config.diagnostics'
require 'plugins.cmp'
require 'plugins.dap'
require 'config.lsp'
require 'config.telescope'
