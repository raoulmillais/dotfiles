-- spec/core/process_spec.lua (Fixed for Plenary.nvim)

local Command = require('core.command')

describe("Command class", function()
  local process

  after_each(function()
    if process and process:is_alive() then
      process:kill("sigkill")
      vim.wait(100)
    end
    process = nil
  end)

  describe("constructor", function()
    it("should create a new process instance", function()
      process = Command.new({
        cmd = "echo",
        args = {"hello"}
      })

      assert.is_not_nil(process)
      assert.is_false(process:is_alive())
    end)

    it("should require cmd parameter", function()
      assert.has_error(function()
        ---@diagnostic disable-next-line missing-fields
        Command.new({})
      end, "cmd is required")
    end)
  end)

  describe("basic command execution", function()
    it("should execute echo command and capture stdout", function()
      local stdout_lines = {}
      local exit_code = nil
      local exit_signal = nil

      process = Command.new({
        cmd = "echo",
        args = {"hello", "world"},
        on_std_out_line = function(line)
          table.insert(stdout_lines, line)
        end,
        on_exit = function(code, signal)
          exit_code = code
          exit_signal = signal
        end
      })

      local success, err = process:run()
      assert.is_true(success, "Command should start: " .. (err or ""))
      assert.is_true(process:is_alive())
      assert.is_number(process:get_pid())

      -- Wait for process to complete
      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete within 5 seconds")
      assert.equals(0, exit_code)
      assert.equals(1, #stdout_lines)
      assert.equals("hello world", stdout_lines[1])
    end)

    it("should handle command not found error", function()
      local exit_code = nil

      process = Command.new({
        cmd = "nonexistent-command-12345",
        on_exit = function(code, signal)
          exit_code = code
        end
      })

      local success, err = process:run()

      if not success then
        -- Spawn failed immediately
        assert.is_string(err)
        assert.matches("Failed to spawn", err)
      else
        -- Wait for exit (might succeed but then fail)
        vim.wait(2000, function() return exit_code ~= nil end)
        if exit_code then
          assert.is_not.equals(0, exit_code)
        end
      end
    end)
  end)

  describe("stderr handling", function()
    it("should capture stderr output", function()
      local stderr_lines = {}
      local exit_code = nil

      process = Command.new({
        cmd = "sh",
        args = {"-c", "echo 'error message' >&2"},
        on_std_err_line = function(line)
          table.insert(stderr_lines, line)
        end,
        on_exit = function(code, signal)
          exit_code = code
        end
      })

      local success = process:run()
      assert.is_true(success)

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)
      assert.equals(1, #stderr_lines)
      assert.equals("error message", stderr_lines[1])
    end)
  end)

  describe("stdin interaction", function()
    it("should send input to process stdin", function()
      local stdout_lines = {}
      local exit_code = nil

      process = Command.new({
        cmd = "cat", -- cat echoes stdin to stdout
        on_std_out_line = function(line)
          table.insert(stdout_lines, line)
        end,
        on_exit = function(code, signal)
          exit_code = code
        end
      })

      local success = process:run()
      assert.is_true(success)

      -- Send input
      process:write("line1\nline2\n")

      -- Close stdin to signal EOF
      process:close_stdin()

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)
      assert.equals(2, #stdout_lines)
      assert.equals("line1", stdout_lines[1])
      assert.equals("line2", stdout_lines[2])
    end)

    it("should handle grep with input", function()
      local stdout_lines = {}
      local exit_code = nil

      process = Command.new({
        cmd = "grep",
        args = {"test"},
        on_std_out_line = function(line)
          table.insert(stdout_lines, line)
        end,
        on_exit = function(code, _)
          exit_code = code
        end
      })

      local success = process:run()
      assert.is_true(success)

      process:write("test line 1\n")
      process:write("no match here\n")
      process:write("another test\n")
      process:write("also no match\n")
      process:close_stdin()

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)
      assert.equals(2, #stdout_lines)
      assert.equals("test line 1", stdout_lines[1])
      assert.equals("another test", stdout_lines[2])
    end)
  end)

  describe("process control", function()
    it("should kill a long-running process", function()
      local exit_code = nil
      local exit_signal = nil

      process = Command.new({
        cmd = "sleep",
        args = {"10"},
        on_exit = function(code, signal)
          exit_code = code
          exit_signal = signal
        end
      })

      local success = process:run()
      assert.is_true(success)
      assert.is_true(process:is_alive())

      -- Kill after a short delay
      vim.defer_fn(function()
        if process:is_alive() then
          local kill_success = process:kill("sigterm")
          assert.is_true(kill_success)
        end
      end, 100)

      local completed = vim.wait(5000, function()
        return exit_signal ~= nil
      end)

      assert.is_true(completed, "Command should be killed")
      assert.is_not.equals(0, exit_signal) -- Command was killed
    end)

    it("should not allow killing a non-running process", function()
      process = Command.new({
        cmd = "echo",
        args = {"test"}
      })

      local kill_success = process:kill()
      assert.is_false(kill_success)
    end)
  end)

  describe("line buffering", function()
    it("should handle partial lines correctly", function()
      local stdout_lines = {}
      local exit_code = nil

      process = Command.new({
        cmd = "sh",
        args = {"-c", "printf 'line1\\nline2\\npartial'"},
        on_std_out_line = function(line)
          table.insert(stdout_lines, line)
        end,
        on_exit = function(code, _)
          exit_code = code
        end
      })

      local success = process:run()
      assert.is_true(success)

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)
      assert.equals(3, #stdout_lines)
      assert.equals("line1", stdout_lines[1])
      assert.equals("line2", stdout_lines[2])
      assert.equals("partial", stdout_lines[3]) -- Last line without newline
    end)

    it("should handle empty lines", function()
      local stdout_lines = {}
      local exit_code = nil

      process = Command.new({
        cmd = "sh",
        args = {"-c", "printf 'line1\\n\\nline3\\n'"},
        on_std_out_line = function(line)
          table.insert(stdout_lines, line)
        end,
        on_exit = function(code, _)
          exit_code = code
        end
      })

      local success = process:run()
      assert.is_true(success)

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)
      assert.equals(3, #stdout_lines)
      assert.equals("line1", stdout_lines[1])
      assert.equals("", stdout_lines[2]) -- Empty line
      assert.equals("line3", stdout_lines[3])
    end)
  end)

  describe("error conditions", function()
    it("should not allow running the same process twice", function()
      local exit_code = nil

      process = Command.new({
        cmd = "sleep",
        args = {"1"},
        on_exit = function(code, _)
          exit_code = code
        end
      })

      local success1 = process:run()
      assert.is_true(success1)

      local success2, err = process:run()
      assert.is_false(success2)
      assert.is_string(err)
      assert.matches("already running", err)

      -- Wait for original process to complete
      vim.wait(2000, function() return exit_code ~= nil end)
    end)

    it("should handle write to closed stdin gracefully", function()
      local exit_code = nil

      process = Command.new({
        cmd = "echo",
        args = {"test"},
        on_exit = function(code, _)
          exit_code = code
        end
      })

      process:run()

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)

      -- Try to write after process has exited
      local write_success = process:write("should fail")
      assert.is_false(write_success)
    end)
  end)

  describe("integration tests", function()
    it("should work with wc command", function()
      local stdout_lines = {}
      local exit_code = nil

      process = Command.new({
        cmd = "wc",
        args = {"-l"},
        on_std_out_line = function(line)
          table.insert(stdout_lines, line)
        end,
        on_exit = function(code, _)
          exit_code = code
        end
      })

      local success = process:run()
      assert.is_true(success)

      process:write("line 1\n")
      process:write("line 2\n")
      process:write("line 3\n")
      process:close_stdin()

      local completed = vim.wait(5000, function()
        return exit_code ~= nil
      end)

      assert.is_true(completed, "Command should complete")
      assert.equals(0, exit_code)
      assert.equals(1, #stdout_lines)
      -- wc -l should report 3 lines
      assert.matches("3", stdout_lines[1])
    end)
  end)
end)
