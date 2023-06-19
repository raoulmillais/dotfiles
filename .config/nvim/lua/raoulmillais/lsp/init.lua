local keymappings = require('raoulmillais.lsp.keymappings')
local set_keymappings = keymappings.on_attach

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
-- Provides lsp for your nvim lua config
require("neodev").setup {}

-- Allows installing new lsp servers from within nvim
require("mason").setup {}
-- Bridges gap between mason and lspconfig (eg. old server names)
require("mason-lspconfig")

local capabilities = require("cmp_nvim_lsp")
      .default_capabilities()

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
    capabilities = capabilities,
  }
end

-- Servers with custom setup

lspconfig.denols.setup {
  on_attach = set_keymappings,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  on_attach = set_keymappings,
  root_dir = lspconfig.util.root_pattern("package.json"),
  capabilities = capabilities,
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
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = set_keymappings,
  settings = require('raoulmillais.lsp.servers.lua_ls').settings,
  capabilities = capabilities,
}

require('rust-tools').setup {
  on_attach = set_keymappings,
  capabilities = capabilities,
}

local builtins = require("null-ls").builtins
require("null-ls").setup {
  sources = {
    builtins.completion.luasnip,
    builtins.diagnostics.shellcheck,
    builtins.formatting.stylua,
  },
}

-- Status messages in bottom right for what the LSP servers are doing
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
