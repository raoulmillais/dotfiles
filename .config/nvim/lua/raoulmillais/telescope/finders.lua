local builtin = require('telescope.builtin')
local themes = require('raoulmillais.telescope.themes')

local M =  {}

M.find_file_in_project = function()
  local opts = themes.top_dropdown_without_preview({
    prompt_title = "Find file in project"
  })
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

function M.find_nvim_config_file()
  local opts = themes.top_dropdown_without_preview({
    prompt_title = "Find neovim config file"
  })
  builtin.find_files(opts)
end

return M
