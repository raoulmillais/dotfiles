return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = "VeryLazy",
    enabled = true
  },
  {
    'nvim-treesitter/nvim-treesitter',
    -- last release is very old
    version = false,
    event = { "VeryLazy" },
    -- don't lazy load when opening a file on the cmdline
    lazy = vim.fn.argc(-1) == 0,
    build = ":TSUpdate",
    opts = {
      ensure_installed = "all",
      sync_install = false,
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
        indent = {
          enable = true
        }
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}
