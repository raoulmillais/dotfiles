-- [
-- Ensure lazy is installed
-- ]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [
-- Configure lazy
-- ]
local lazy = require('lazy')

-- These options must be set right at the start before lazy
vim.g.mapleader = ","
vim.g.maplocalleader = ","

lazy.setup({
  spec = { import = "plugins" },
  performance = {
    cache = { enabled = true },
    -- reset the package path to improve startup time
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  }
})

-- [
-- Configure neovim
-- ]
require 'config.options'
require 'config.autocommands'
require 'config.keymaps'
require 'config.lsp'
require 'config.telescope'
require 'config.diagnostics'
