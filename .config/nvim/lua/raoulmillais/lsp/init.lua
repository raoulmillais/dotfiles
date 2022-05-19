local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  buf_map(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_map(bufnr, 'n', '<leader>cy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 
  'bashls',
  'gopls', 
  'html', 
  'rust_analyzer', 
  'tailwindcss', 
  'tsserver', 
  'vimls' 
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach
  }
end
