local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  defaults = {
    winblend = 30,
  },
}
telescope.load_extension 'fzf'

nmap('<leader>td', builtin.diagnostics)
nmap('<leader>ff', builtin.find_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)

