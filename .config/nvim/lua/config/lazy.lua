-- BUNDLED PLUGINS {{{1
-- Use the matchit macro to enable switching between open close tags and
-- if/elsif/else/end with %
vim.cmd[[runtime macros/matchit.vim]]
vim.cmd[[runtime ftplugin/man.vim]]  -- Enable viewing man pages
-- }}}
--
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  -- Should not get here - lazy-install.lua should run first
  print("Lazy not installed")
  return
end

lazy.setup({
  { import = "plugins" },
  'ellisonleao/gruvbox.nvim',
  {
    'echasnovski/mini.pairs',
    version = '*'
  },
  'gpanders/editorconfig.nvim',
  'windwp/nvim-ts-autotag',

  'simrat39/rust-tools.nvim',
  'MunifTanjim/prettier.nvim',

  'mhinz/vim-startify',
  'othree/yajs.vim',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'jremmen/vim-ripgrep',
  'vim-scripts/scratch.vim',
  'vifm/vifm.vim',

  { "folke/neoconf.nvim", cmd = "Neoconf" },
})
