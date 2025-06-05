local hl = require('core.hl')

return {
  'saghen/blink.cmp',
  dependencies = {
    'Kaiser-Yang/blink-cmp-avante',
    'rafamadriz/friendly-snippets'
  },
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    signature = { enabled = true },
    sources = {
      default = { 'avante', 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = { }
        }
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
  init = function()
    hl.set(0, 'BlinkCmpMenu', { bg = '#1d2021' })
    hl.set(0, 'BlinkCmpMenuBorder', { bg = '#1d2021' })
  end
}
