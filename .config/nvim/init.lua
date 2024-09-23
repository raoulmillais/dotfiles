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
require 'config.icons'
require 'config.autocommands'
require 'config.keymaps'
require 'config.lsp'
require 'config.telescope'
require 'config.diagnostics'
