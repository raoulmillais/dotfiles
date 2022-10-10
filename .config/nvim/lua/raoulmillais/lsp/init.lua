local signs = require('raoulmillais.config').signs
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
nmap("<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

local set_keybindings = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  set_buf(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  nmap_buf(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  nmap_buf(bufnr, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  nmap_buf(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  nmap_buf(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  nmap_buf(bufnr, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  nmap_buf(bufnr, "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  nmap_buf(bufnr, "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  nmap_buf(bufnr, "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  nmap_buf(bufnr, "<leader>cy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  nmap_buf(bufnr, "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  nmap_buf(bufnr, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  nmap_buf(bufnr, "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  nmap_buf(bufnr, "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

require("nvim-lsp-installer").setup {}

require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

-- servers with no special settings
local servers = {
  "bashls",
  "gopls",
  "html",
  "rust_analyzer",
  "tailwindcss",
  "vimls",
}

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = set_keybindings,
  }
end

-- Servers with custom setup

lspconfig.denols.setup {
  on_attach = set_keybindings,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
  on_attach = set_keybindings,
  root_dir = lspconfig.util.root_pattern("package.json"),
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

lspconfig.jsonls.setup {
  on_attach = set_keybindings,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

lspconfig.sumneko_lua.setup {
  on_attach = set_keybindings,
  settings = require('raoulmillais.lsp.servers.sumneko_lua').settings,
}

require('rust-tools').setup {
  on_attach = set_keybindings
}

local builtins = require("null-ls").builtins
require("null-ls").setup {
  sources = {
    builtins.code_actions.gitsigns,
    builtins.code_actions.refactoring,
    builtins.code_actions.shellcheck,
    builtins.completion.luasnip,
    builtins.completion.spell,
    builtins.diagnostics.shellcheck,
    builtins.formatting.stylua,
  },
}

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

require("fidget").setup {
  text = {
    spinner = "moon",
  },
  align = {
    bottom = true,
  },
  window = {
    relative = "editor",
  },
}

-- DIAGNOSTICS

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- Use a float instead of virtual text for diagnostics
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
