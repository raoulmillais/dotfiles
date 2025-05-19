return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    version = false,
    dependencies = {
      "github/copilot.vim",
      "MunifTanjim/nui.nvim",
    },
    opts = require("config.avante").opts,
    keys = require("config.avante").keys,
    config = function(_, opts)
      require("avante").setup(opts)
      -- disable floating input hint
      local sidebar = require "avante.sidebar"
      if sidebar then
        sidebar.show_input_hint = function() end
        sidebar.close_input_hint = function() end
      end
    end,
  },
  {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = { "Copilot" },
  }
}
