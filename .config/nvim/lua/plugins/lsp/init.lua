local set_keymaps = require('plugins.lsp.keymaps').on_attach

local function keys(t)
   local l = {}
   for k in pairs(t) do
      l[#l + 1] = k
   end
   return l
end

return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'sar/schemastore.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp'
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    servers = {
      denols = function()
        local lspconfig = require('lspconfig')

        return {
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        }
      end,
      ts_ls = function()
        local lspconfig = require('lspconfig')

        return {
          root_dir = lspconfig.util.root_pattern("package.json"),
        }
      end,
      jsonls = function()
        local schemastore = require('schemastore')
        return {
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
            }
          }
        }
      end,
      lua_ls = {
        settings = {
          diagnostics = {
            globals = {
              'vim', 'bit', 'imap', 'nmap', 'cmap', 'setbuf', 'nmap_buf'
            },
            workspace = {
              checkThirdParty = false
            }
          }
        }
      },
      bashls = {},
      gopls = {},
      html = {},
      rust_analyzer = {},
      tailwindcss = {},
    },
    config = function(opts)
      require("mason").setup()
      require("mason-lspconfig").setup({ ensure_installed = keys(opts.servers) })

      local function setup(server)
        local server_opts = {}
        if type(opts.servers[server]) == "function" then
          server_opts = opts.servers[server]()
        else
          server_opts = opts.servers[server] or {}
        end

        local final_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = set_keymaps
        }, server_opts)

        if final_opts.enabled == false then
          return
        end

        require("lspconfig")[server].setup(final_opts)
      end

      for server, server_opts in pairs(opts.servers) do
        if server_opts then
            setup(server)
        end
      end
    end
  }
}
