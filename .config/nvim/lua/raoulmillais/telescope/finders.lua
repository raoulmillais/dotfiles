local builtin = require('telescope.builtin')
local tt = require('telescope.themes')
local themes = require('raoulmillais.telescope.themes')
local exec = require('raoulmillais.exec')

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
    prompt_title = "Find neovim config file",
    cwd = "~/.config/nvim"
  })
  builtin.find_files(opts)
end

function M.git_status()
  local _, ret = exec({
    "git", "rev-parse", "--show-toplevel"
  }, vim.fn.getcwd())
  if ret ~= 0 then
    error('Not in a git work tree')
    return
  end

  -- TODO: Standardise icons between gitsigns and here
  -- opts.git_icons = {
  --   changed = "M"
  -- }
  local opts = tt.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  builtin.git_status(opts)
end

return M
