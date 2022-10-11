local keymappings = require('raoulmillais.lsp.keymappings')
local set_keymappings = keymappings.on_attach

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
    on_attach = set_keymappings,
  }
end

-- Servers with custom setup

lspconfig.denols.setup {
  on_attach = set_keymappings,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
  on_attach = set_keymappings,
  root_dir = lspconfig.util.root_pattern("package.json"),
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

lspconfig.jsonls.setup {
  on_attach = set_keymappings,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

lspconfig.sumneko_lua.setup {
  on_attach = set_keymappings,
  settings = require('raoulmillais.lsp.servers.sumneko_lua').settings,
}

require('rust-tools').setup {
  on_attach = set_keymappings
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
