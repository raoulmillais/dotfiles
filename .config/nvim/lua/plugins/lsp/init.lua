local set_keymaps = require('plugins.lsp.keymaps').on_attach


return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    init = function(_)
      vim.lsp.enable({
        'bashls',
        'gopls',
        'html',
        'rust_analyzer',
        'tailwindcss',
        'denols',
        'lua_ls'
      })
      require("mason").setup()

    end,
  }
}
