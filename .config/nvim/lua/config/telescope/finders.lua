local builtin = require('telescope.builtin')
local tt = require('telescope.themes')
local themes = require('config.telescope.themes')
local Job = require "plenary.job"

-- Adapted from https://github.com/nvim-telescope/telescope.nvim/blob/54be102e20ee4acaaa17e9fce8be07fb586630df/lua/telescope/utils.lua#L390
local function exec(cmd, cwd)
  if type(cmd) ~= "table" then
    vim.notify("Command has to be a table",  "ERROR")
    return {}
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job
    :new({
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()
  return stdout, ret, stderr
end

local finders =  {}

finders.find_file_in_project = function()
  local opts = themes.top_dropdown_without_preview({
    prompt_title = "Find file in project"
  })
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

function finders.find_nvim_config_file()
  local opts = themes.top_dropdown_without_preview({
    prompt_title = "Find neovim config file",
    cwd = "~/.config/nvim"
  })
  builtin.find_files(opts)
end

function finders.git_status()
  local _, ret = exec({
    "git", "rev-parse", "--show-toplevel"
  }, vim.fn.getcwd())
  if ret ~= 0 then
    error('Not in a git work tree')
    return
  end

  -- TODO: Standardise icons between gitsigns and here
  -- opts.git_icons = {
  --   changed = "finders"
  -- }
  local opts = tt.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  builtin.git_status(opts)
end

return finders
