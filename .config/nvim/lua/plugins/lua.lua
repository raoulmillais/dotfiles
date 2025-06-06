return {
  { 'milisims/nvim-luaref' },
  -- `vim.uv` typings
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Always load luvit types - I only use lua for neovim
        { path = "${3rd}/luv/library" },
      },
    },
  },
}
