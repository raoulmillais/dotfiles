local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

telescope.setup {
  extensions = {
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

telescope.load_extension 'fzf'

local function project_find_drop_down()
  return themes.get_dropdown({
    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
    },
    prompt_prefix = "🔍 ",
    prompt_title = "Find in project",
    previewer = false,
    layout_strategy = "center",
    layout_config = {
      prompt_position = "top",
      width = function(_, max_columns, _)
        return math.min(max_columns, 80)
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines, 15)
      end,
    },
    results_title = false,
    sorting_strategy = "descending",
    shorten_path = true
  })
end

local function find_file_in_project()
  local ok = pcall(builtin.git_files, project_find_drop_down())
  if not ok then
    builtin.find_files(project_find_drop_down())
  end
end

nmap('<leader>td', builtin.diagnostics)
nmap('<leader>ff', builtin.find_files)
nmap('<leader>fg', builtin.live_grep)
nmap('<leader>fb', builtin.buffers)
nmap('<leader>fh', builtin.help_tags)
nmap('<leader>fi', find_file_in_project)
