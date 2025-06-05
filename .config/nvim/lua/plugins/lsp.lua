return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    init = function(_)
      require("mason").setup()
      vim.lsp.enable({
        'ts_ls',
        'bashls',
        'gopls',
        'html',
        'rust_analyzer',
        'tailwindcss',
        'denols',
        'lua_ls'
      })
    end,
  }
}
