local c = require('core')
local opts = { noremap = true, silent = true }

return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
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
      vim.api.nvim_create_autocmd('LspAttach', {
        group = c.augroup("attach_lsp_keybinds"),
        callback = function (args)
          local keymaps = require('config.keymaps')
          local bufnr = args.buf
          for _, km in pairs(keymaps.lsp) do
            local lhs, rhs, o = unpack(km)
            c.merge(o, opts)
            c.nmap_buf(bufnr, lhs, rhs, o)
          end
        end
      })
    end,
  }
}
