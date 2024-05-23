local keymaps = require('config.lsp.keymaps')
local set_keymaps = keymaps.on_attach

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
    on_attach = set_keymaps,
    capabilities = capabilities,
  }
end

-- Servers with custom setup

lspconfig.denols.setup {
  on_attach = set_keymaps,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  on_attach = set_keymaps,
  root_dir = lspconfig.util.root_pattern("package.json"),
  capabilities = capabilities,
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

lspconfig.jsonls.setup {
  on_attach = set_keymaps,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = set_keymaps,
  settings = require('config.lsp.servers.lua_ls').settings,
  capabilities = capabilities,
}

local rust_tools = require('rust-tools')
local rust_on_attach = function(_, bufnr)
  set_keymaps(_, bufnr)
  rust_tools.hover_actions.hover_actions()
end
require('rust-tools').setup {
  on_attach = rust_on_attach,
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
require("fidget").setup { }
