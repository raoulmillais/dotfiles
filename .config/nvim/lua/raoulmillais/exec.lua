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

return exec
