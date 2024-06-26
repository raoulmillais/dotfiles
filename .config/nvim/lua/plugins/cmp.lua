local cmp = require('cmp')
local lspkind = require('lspkind')

-- Adds pretty pictograms to the lsp pum
lspkind.init()

cmp.setup {
  preselect = cmp.PreselectMode.None,
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol",
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = "gh_issues" },
    { name = "nvim_lua" },
    { name = 'conjure' },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
  }),
}

-- Use text in buffer for completing searches
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'nvim_lsp_document_symbol' } },
  { { name = 'buffer' } }) })

-- Use cmdline & paths for the command line
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

