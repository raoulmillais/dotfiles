local c = require('core')

return {
  {
    "nvim-tree/nvim-web-devicons" ,
    opts = {
      -- the colors clash with gruvbox
      color_icons = false
    },
    init = function ()
      -- This is the only way to change all the icons to a gruvbox colour
      -- https://github.com/nvim-tree/nvim-web-devicons/issues/101
      local nvim_web_devicons = require("nvim-web-devicons")
      local current_icons = nvim_web_devicons.get_icons()
      local new_icons = {}

      for key, icon in pairs(current_icons) do
          icon.color = "#d5c4a1"
          new_icons[key] = icon
      end

      nvim_web_devicons.set_icon(new_icons)
    end,
  },
  { "MunifTanjim/nui.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      popup_border_style = "",
      color_icons = false,
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        }
      },
      window = {
        mappings = {
          ["<C-x>"] = "open_split",
          ["<C-v>"] = "open_vsplit",
      },
      },
      event_handlers = {
        {
          event = "after_render",
          handler = function()
            -- This can only be set here - doing it iin the ftplugin causes
            -- the tree to not render until a key is pressed
            vim.opt_local.fillchars = { eob = ' ' }
          end
        }
      }
    },
    init = function()
      local keymaps = require('config.keymaps')
      c.register_normal_keymaps(keymaps.neotree)
    end
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function(_, _)
      local bl = require('bufferline')
      bl.setup({
        options = {
          separator_style = 'slant',
          show_close_icon = false,
          mode = "tabs",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "center"
            }
          }
        }
      })
      end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = 'helix',
      win = {
        height = { min = 10, max = 25 },
        wo = {
          winblend = 0
        }

      },
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
