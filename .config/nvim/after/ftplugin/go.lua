-- Don't load this multiple times
if vim.b.ftplugin_loaded then
  return
end
vim.b.ftplugin_loaded = true

local c = require('core')
local augroup = require('core.augroup')

vim.opt_local.tabstop = 4
vim.cmd("compiler go")

c.autocmd("QuickFixCmdPost", {
  group = augroup.create("open_qf_when_build_fails"),
  pattern = "make", -- pattern is matched against the command being run
  callback = function()
    local qf_is_open = vim.fn.getqflist({winid = 0}).winid > 0
    -- Only open if there are errors and quickfix window isn't already open
    -- The `getqflist` function is weird it does completely different things
    -- depending on its `{what}` argument see `:h getqflist-examples`
    if #vim.fn.getqflist() > 0 and not qf_is_open then
      vim.cmd("copen")
    elseif qf_is_open then
      -- close it if the build succeeded and it was open
      vim.cmd("cclose")
    end
  end,
  desc = "Auto-open quickfix when the build fails"
})

--[[
--  GoTest with population of the quickfix
--]]
--
-- Extract relative path and line number from a stack trace line
local function extract_stack_trace_info(line, module_name)
  -- Look for stack trace pattern: "    /full/path/file.go:123 +0x..."
  local abs_path, lnum = line:match("%s*([^:]+%.go):(%d+)%s+%+0x")

  if not abs_path or not lnum then
    print('Saw a non-stack trace line: ' .. line)
    return nil, nil
  end

  -- Extract the last component(s) of the module name
  local module_parts = vim.split(module_name, "/")
  local module_suffix = table.concat({module_parts[#module_parts-1], module_parts[#module_parts]}, "/")

  -- Try matching with the suffix first
  local pattern = "/" .. vim.pesc(module_suffix) .. "/(.+)$"
  print("Module suffix: '" .. module_suffix .. "'")
  print("Pattern: '" .. pattern .. "'")
  local rel_path = abs_path:match(pattern)

  if rel_path then
    print('Extracted from stackline: ' .. rel_path .. ' line: ' .. lnum)
    return rel_path, tonumber(lnum)  -- Return both path and line number
  else
    print('Pattern did not match!')
    return nil, nil  -- Return nil for both if no match
  end
end

-- Process a complete failed test block until we hit another test or EOF
local function process_test_block(lines, last_seen_idx, test_name, module_name, qf_entries)
  local next_line_idx = last_seen_idx + 1  -- Start after the FAIL line
  local pending_error = {
    filename = "unknown",
    lnum = 0,
    text = test_name,
    type = "E"
  }

  print("Processing test block" .. test_name)
  while next_line_idx <= #lines do
    local line = lines[next_line_idx]

    local seen_fail = line:match("^%-%-%- FAIL:") or line:match("^FAIL:")
    if seen_fail then
       print("stopping scanning as we found the FAIL message that ends the block")
      if pending_error then
        table.insert(qf_entries, pending_error)
      end
      return next_line_idx
    end

    local seen_pass = line:match("^%-%-%- PASS:")
    if seen_pass then
       print("stopping scanning as we found the PASS message that ends the block")
      return next_line_idx
    end

    -- Must be a stacktrace line
    local stack_path, stack_lnum = extract_stack_trace_info(line, module_name)
    if stack_path then -- got what we needed
      print('found a stack line in our module')
      pending_error.filename = stack_path
      pending_error.lnum = stack_lnum

      table.insert(qf_entries, pending_error)
      return next_line_idx
    end

    next_line_idx = next_line_idx + 1
  end

  -- Add any pending error at EOF
  table.insert(qf_entries, pending_error)
  return next_line_idx
end

-- Function to parse go test verbose output and populate quickfix
local function go_test_quickfix()
  -- Determine test command
  local test_cmd
  if vim.fn.filereadable("makefile") == 1 or vim.fn.filereadable("Makefile") == 1 then
    test_cmd = "make test"
  else
    test_cmd = "go test -v ./..."
  end

  -- Read go.mod to get module name
  local module_name = nil
  if vim.fn.filereadable("go.mod") == 1 then
    local go_mod_content = vim.fn.readfile("go.mod")
    for _, line in ipairs(go_mod_content) do
      local mod = line:match("^module%s+(.+)")
      if mod then
        module_name = mod
        break
      end
    end
  end

  -- Run the command and capture output
  local output = vim.fn.system(test_cmd)
  local exit_code = vim.v.shell_error

  local qf_entries = {}

  if exit_code ~= 0 then
    local lines = vim.split(output, "\n")
    local i = 1

    while i <= #lines do
      local line = lines[i]

      print(line)
      -- Look for the beginning of a test block
      local test_name = line:match("=== RUN%s+(.+)") or line:match("^%-%-%- FAIL:%s+([^%s]+)")
      if test_name then
        print("Found a test: " .. test_name)
        -- Get the message from the next line
        i = i + 1
        line = lines[i]
        local message = line:match("%s*[^%s/]+%.go:%d+:%s*(.*)")
        i = process_test_block(lines, i, test_name .. ": " .. message, module_name, qf_entries)
      else
        i = i + 1
      end
    end

    -- If no specific errors found but tests failed, add a general failure
    if #qf_entries == 0 then
      table.insert(qf_entries, {
        text = "Tests failed but no parseable errors found. Check :messages",
        type = "E"
      })
    end
  end

  -- Set quickfix list
  vim.fn.setqflist(qf_entries, "r")

  -- Show results
  if #qf_entries > 0 then
    vim.cmd("copen")
  else
    if exit_code == 0 then
      print("All tests passed!")
    else
      print("Tests failed but no parseable errors found. Check :messages")
      vim.fn.setqflist({{text = "Test command failed. See :messages for full output", type = "E"}}, "r")
      vim.cmd("copen")
    end
  end
end

-- Create buffer-local command for testing
vim.api.nvim_buf_create_user_command(0, "GoTest", go_test_quickfix, {
  desc = "Run Go tests and populate quickfix with failures"
})
