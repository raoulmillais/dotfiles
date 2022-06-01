local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local finders = require('raoulmillais.telescope.finders')

telescope.setup {
  extensions = {
    ["ui-select"] = {
      require('telescope.themes').get_dropdown{}
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  color_devicons = true,
  defaults = {
    winblend = 30,
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  scroll_strategy = "cycle"
}

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

nmap('<leader>td', builtin.diagnostics)
nmap('<leader>ta', vim.lsp.buf.code_action)
nmap('<leader>tgs', finders.git_status)

-- Find
nmap('<leader>ff', builtin.find_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)

nmap('<leader>fi', finders.find_file_in_project)
nmap('<leader>fn', finders. find_nvim_config_file)
