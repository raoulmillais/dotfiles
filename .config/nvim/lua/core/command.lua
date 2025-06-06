local uv = vim.uv

---@class CommandOptions
---@field cmd string The command to execute
---@field args string[]? Arguments to pass to the command
---@field cwd string? Working directory for the process
---@field env table<string, string>? Environment variables
---@field on_std_out_line fun(line: string)? Handler for stdout lines
---@field on_std_err_line fun(line: string)? Handler for stderr lines
---@field on_exit fun(code: integer, signal: integer)? Handler for process exit

---@class Command
---@field private options CommandOptions
---@field private process_handle uv.uv_process_t?
---@field private pid integer?
---@field private stdin uv.uv_pipe_t?
---@field private stdout uv.uv_pipe_t?
---@field private stderr uv.uv_pipe_t?
---@field private stdout_buffer string
---@field private stderr_buffer string
---@field private is_running boolean
local Command = {}
Command.__index = Command

---Create a new Command instance
---@param options CommandOptions
---@return Command
function Command.new(options)
  assert(options.cmd, "cmd is required")

  local self = setmetatable({
    options = options,
    process_handle = nil,
    pid = nil,
    stdin = nil,
    stdout = nil,
    stderr = nil,
    stdout_buffer = "",
    stderr_buffer = "",
    is_running = false,
  }, Command)

  return self
end

---Command buffered data and extract complete lines
---@param buffer string Current buffer content
---@param new_data string? New data to append (nil for EOF)
---@param line_handler fun(line: string)? Handler for complete lines
---@return string updated_buffer
function Command:_process_lines(buffer, new_data, line_handler)
  if new_data then
    buffer = buffer .. new_data
  end

  while true do
    local line_end = buffer:find('\n')
    if not line_end then
      break
    end

    local line = buffer:sub(1, line_end - 1)
    buffer = buffer:sub(line_end + 1)

    if line_handler then
      line_handler(line)
    end
  end

  -- Handle remaining data on EOF
  if not new_data and buffer ~= "" and line_handler then
    line_handler(buffer)
    buffer = ""
  end

  return buffer
end

---Setup stdout reading
---@private
function Command:_setup_stdout()
  if not self.stdout then return end

  self.stdout:read_start(function(err, data)
    if err then
      if self.options.on_std_err_line then
        self.options.on_std_err_line("stdout read error: " .. err)
      end
      return
    end

    self.stdout_buffer = self:_process_lines(
      self.stdout_buffer,
      data,
      self.options.on_std_out_line
    )
  end)
end

---Setup stderr reading
---@private
function Command:_setup_stderr()
  if not self.stderr then return end

  self.stderr:read_start(function(err, data)
    if err then
      if self.options.on_std_err_line then
        self.options.on_std_err_line("stderr read error: " .. err)
      end
      return
    end

    self.stderr_buffer = self:_process_lines(
      self.stderr_buffer,
      data,
      self.options.on_std_err_line
    )
  end)
end

---Start the process
---@return boolean success
---@return string? error_message
function Command:run()
  if self.is_running then
    return false, "Command is already running"
  end

  -- Create pipes for stdio
  self.stdin = uv.new_pipe()
  self.stdout = uv.new_pipe()
  self.stderr = uv.new_pipe()

  if not self.stdin or not self.stdout or not self.stderr then
    return false, "Failed to create pipes"
  end

  -- Prepare spawn options
  local spawn_options = {
    args = self.options.args,
    stdio = { self.stdin, self.stdout, self.stderr },
    cwd = self.options.cwd,
    env = self.options.env,
  }

  -- Spawn the process
  local process_handle, pid = uv.spawn(self.options.cmd, spawn_options, function(code, signal)
    self.is_running = false

    -- Command any remaining buffered data
    if self.stdout_buffer ~= "" and self.options.on_std_out_line then
      self.options.on_std_out_line(self.stdout_buffer)
      self.stdout_buffer = ""
    end

    if self.stderr_buffer ~= "" and self.options.on_std_err_line then
      self.options.on_std_err_line(self.stderr_buffer)
      self.stderr_buffer = ""
    end

    -- Call exit handler
    if self.options.on_exit then
      self.options.on_exit(code, signal)
    end

    -- Cleanup
    self:_cleanup()
  end)

  if not process_handle then
    self:_cleanup()
    return false, "Failed to spawn process: " .. (pid or "unknown error")
  end

  self.process_handle = process_handle
  self.pid = pid
  self.is_running = true

  -- Setup reading from stdout and stderr
  self:_setup_stdout()
  self:_setup_stderr()

  return true
end

---Write data to process stdin
---@param data string
---@return boolean success
function Command:write(data)
  if not self.is_running or not self.stdin then
    return false
  end

  self.stdin:write(data)
  return true
end

---Close stdin (send EOF)
---@param callback fun()? Optional callback when shutdown completes
function Command:close_stdin(callback)
  if not self.stdin then
    if callback then callback() end
    return
  end

  self.stdin:shutdown(callback)
end

---Kill the process
---@param signal string? Signal name (default: "sigterm")
---@return boolean success
function Command:kill(signal)
  if not self.is_running or not self.process_handle then
    return false
  end

  signal = signal or "sigterm"
  local success = pcall(function()
    self.process_handle:kill(signal)
  end)

  return success
end

---Check if process is running
---@return boolean
function Command:is_alive()
  return self.is_running
end

---Get process PID
---@return integer?
function Command:get_pid()
  return self.pid
end

---Cleanup resources
---@private
function Command:_cleanup()
  if self.stdout then
    self.stdout:read_stop()
    self.stdout:close()
    self.stdout = nil
  end

  if self.stderr then
    self.stderr:read_stop()
    self.stderr:close()
    self.stderr = nil
  end

  if self.stdin then
    self.stdin:close()
    self.stdin = nil
  end

  if self.process_handle then
    self.process_handle:close()
    self.process_handle = nil
  end

  self.pid = nil
end

return Command
