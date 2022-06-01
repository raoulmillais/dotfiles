local themes = require('telescope.themes')

local M = {}

M.project_find_drop_down = function()
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


return M
