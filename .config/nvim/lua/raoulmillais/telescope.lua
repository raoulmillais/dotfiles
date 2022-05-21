require('telescope').setup{
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  },
  defaults = {
    winblend = 30
  }
}
require('telescope').load_extension('fzf')

nmap("<leader>td", ":Telescope diagnostics<CR>")
