-- TODO: Move telescope here
return {
  { "nvim-lua/plenary.nvim"},
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
     "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    default_component_configs = {
      indent = {
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          unstaged = "󰄱",
          staged = "󰱒",
        },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        mode = { "n", "v" },
        { "<leader>t", group = "[T]abs" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>e", group = "[E]valuate (conjure)" },
        { "<leader>f", group = "[F]ile/find" },
        { "<leader>l", group = "[L]og (conjure)" }, -- FIXME: Make this a buflocal set of maps
        { "<leader>g", group = "[G]it" },
        { "<leader>q", group = "[Q]uit/session" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>v", group = "[V]imux" }, -- TODO: Should this be a global top-level group?
        { "<leader>u", group = "[U]i", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>d", group = "[D]iagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "[B]uffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "[W]indows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        { "gx", desc = "Open with system app" },
      },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
}
