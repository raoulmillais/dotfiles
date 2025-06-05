return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false
        }
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        extensions = {
            avante = {
                make_slash_commands = true, -- make /slash commands from MCP server prompts
            }
        }
      })
    end
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    version = false,
    dependencies = {
      "zbirenbaum/copilot.lua",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          proxy = nil,
          allow_insecure = false,
          timeout = 10 * 60 * 1000,
          extra_request_body = {
            temperature = 0,
          },
          max_completion_tokens = 1000000,
          reasoning_effort = "high",
          model = "claude-sonnet-4",
        },
      },
      windows = {
        ask = {
          border = "rounded",
          floating = false,
          start_insert = true,
        },
        edit = {
          border = "single",
          start_insert = true,
        },
      },
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
  },
}
