local themes = require('telescope.themes')

local M = {}

M.top_dropdown_without_preview = function(opts)
  opts = opts or {}

  local theme_opts = themes.get_dropdown({
    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
    },
    prompt_prefix = "🔍 ",
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

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

return M
