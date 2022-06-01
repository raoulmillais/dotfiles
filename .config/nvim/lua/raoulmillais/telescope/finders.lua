local builtin = require('telescope.builtin')
local themes = require('raoulmillais.telescope.themes')

local M =  {}

M.find_file_in_project = function()
  local opts = themes.project_find_drop_down()
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

return M
