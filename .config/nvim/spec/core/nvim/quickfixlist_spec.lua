local QuickFixList = require('core.nvim.quickfixlist')

local eq = assert.are.equal
local same = assert.are.same

describe("QuickFixList", function()
  local qf
  local setqflist_calls
  local cmd_calls
  local original_vim

  before_each(function()
    original_vim = vim

    setqflist_calls = {}
    cmd_calls = {}

    -- Its intentionally shadowing the implementaton
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.fn.setqflist = function(items, action, opts)
      table.insert(setqflist_calls, {
        items = items,
        action = action,
        opts = opts
      })
    end

    vim.cmd = function(command)
      table.insert(cmd_calls, command)
    end

    qf = QuickFixList.new()
  end)

  after_each(function()
    -- Restore original vim
    vim = original_vim
  end)

  describe("constructor", function()
    it("should create a new QuickFixList with default title", function()
      local qf_default = QuickFixList.new()
      eq("Custom Results", qf_default.title)
      assert.is_table(qf_default.items)
      eq(0, #qf_default.items)
    end)

    it("should create a new QuickFixList with custom title", function()
      local qf_custom = QuickFixList.new("My Custom Title")
      eq("My Custom Title", qf_custom.title)
    end)

    it("should call setqflist on creation", function()
      setqflist_calls  = {}
      QuickFixList.new("Test Title")
      eq(1, #setqflist_calls)
      same({}, setqflist_calls[1].items)
      eq('r', setqflist_calls[1].action)
      eq("Test Title", setqflist_calls[1].opts.title)
    end)
  end)

  describe("reset", function()
    it("should clear items and reset quickfix list", function()
      -- Add some items first
      qf:add("test.lua", 1, "test")
      eq(1, qf:count())

      -- Reset should clear everything
      local result = qf:reset()

      eq(0, qf:count())
      eq(qf, result) -- should return self for chaining

      -- Should call setqflist with 'r' action
      local reset_call = setqflist_calls[#setqflist_calls]
      same({}, reset_call.items)
      eq('r', reset_call.action)
    end)
  end)

  describe("add", function()
    it("should add an item with all parameters", function()
      local result = qf:add("test.lua", 10, "Test message", "E", 5)

      eq(qf, result) -- should return self for chaining
      eq(1, qf:count())

      local expected_item = {
        filename = "test.lua",
        lnum = 10,
        text = "Test message",
        type = "E",
        col = 5
      }

      same(expected_item, qf.items[1])

      -- Should call setqflist with append action
      local add_call = setqflist_calls[#setqflist_calls]
      same({expected_item}, add_call.items)
      eq('a', add_call.action)
    end)

    it("should use default values for optional parameters", function()
      qf:add("test.lua", 10, "Test message")

      local expected_item = {
        filename = "test.lua",
        lnum = 10,
        text = "Test message",
        type = "I", -- default type
        col = 1     -- default column
      }

      same(expected_item, qf.items[1])
    end)

    it("should handle multiple items", function()
      qf:add("file1.lua", 1, "First")
      qf:add("file2.lua", 2, "Second")

      eq(2, qf:count())
      eq("file1.lua", qf.items[1].filename)
      eq("file2.lua", qf.items[2].filename)
    end)
  end)

  describe("typed add methods", function()
    it("add_error should add an error item", function()
      qf:add_error("test.lua", 10, "Error message", 5)

      eq(1, qf:count())
      eq("E", qf.items[1].type)
      eq("Error message", qf.items[1].text)
    end)

    it("add_warning should add a warning item", function()
      qf:add_warning("test.lua", 10, "Warning message")

      eq(1, qf:count())
      eq("W", qf.items[1].type)
      eq("Warning message", qf.items[1].text)
    end)

    it("add_info should add an info item", function()
      qf:add_info("test.lua", 10, "Info message")

      eq(1, qf:count())
      eq("I", qf.items[1].type)
      eq("Info message", qf.items[1].text)
    end)

    it("add_note should add a note item", function()
      qf:add_note("test.lua", 10, "Note message")

      eq(1, qf:count())
      eq("N", qf.items[1].type)
      eq("Note message", qf.items[1].text)
    end)

    it("typed methods should support method chaining", function()
      local result = qf:add_error("test.lua", 1, "Error")
                       :add_warning("test.lua", 2, "Warning")
                       :add_info("test.lua", 3, "Info")

      eq(qf, result)
      eq(3, qf:count())
      eq("E", qf.items[1].type)
      eq("W", qf.items[2].type)
      eq("I", qf.items[3].type)
    end)
  end)

  describe("window management", function()
    it("open should execute copen command", function()
      local result = qf:open()

      eq(qf, result) -- should return self for chaining
      eq(1, #cmd_calls)
      eq("copen", cmd_calls[1])
    end)

    it("close should execute cclose command", function()
      local result = qf:close()

      eq(qf, result) -- should return self for chaining
      eq(1, #cmd_calls)
      eq("cclose", cmd_calls[1])
    end)

    it("should support chaining with window commands", function()
      qf:add_error("test.lua", 1, "Error"):open():close()

      eq(2, #cmd_calls)
      eq("copen", cmd_calls[1])
      eq("cclose", cmd_calls[2])
    end)
  end)

  describe("count and empty", function()
    it("count should return number of items", function()
      eq(0, qf:count())

      qf:add("test.lua", 1, "Test")
      eq(1, qf:count())

      qf:add("test.lua", 2, "Test2")
      eq(2, qf:count())
    end)

    it("is_empty should return true when no items", function()
      assert.is_true(qf:is_empty())

      qf:add("test.lua", 1, "Test")
      assert.is_false(qf:is_empty())

      qf:reset()
      assert.is_true(qf:is_empty())
    end)
  end)

  describe("get_items", function()
    it("should return a copy of items", function()
      qf:add("test.lua", 1, "Test")
      local items = qf:get_items()

      eq(1, #items)
      eq("test.lua", items[1].filename)

      -- Should be a copy, not the original
      assert.is_not.equal(qf.items, items)

      -- Modifying returned items shouldn't affect original
      items[1].filename = "modified.lua"
      eq("test.lua", qf.items[1].filename)
    end)

    it("should return empty table when no items", function()
      local items = qf:get_items()
      same({}, items)
    end)
  end)

  describe("title management", function()
    it("get_title should return current title", function()
      local qf_custom = QuickFixList.new("Custom Title")
      eq("Custom Title", qf_custom:get_title())
    end)

    it("set_title should update title and call setqflist", function()
      local result = qf:set_title("New Title")

      eq(qf, result) -- should return self for chaining
      eq("New Title", qf:get_title())

      -- Should call setqflist with append action and new title
      local title_call = setqflist_calls[#setqflist_calls]
      same({}, title_call.items)
      eq('a', title_call.action)
      eq("New Title", title_call.opts.title)
    end)
  end)

  describe("integration scenarios", function()
    it("should handle a complete workflow", function()
      local result = qf:set_title("Linting Results")
                       :add_error("main.lua", 10, "Syntax error")
                       :add_warning("utils.lua", 25, "Unused variable")
                       :add_info("config.lua", 5, "TODO: Refactor")
                       :open()

      eq(qf, result)
      eq(3, qf:count())
      eq("Linting Results", qf:get_title())
      assert.is_false(qf:is_empty())

      -- Should have called copen
      eq(1, #cmd_calls)
      eq("copen", cmd_calls[1])
    end)

    it("should handle reset after adding items", function()
      qf:add_error("test.lua", 1, "Error")
        :add_warning("test.lua", 2, "Warning")
        :reset()
        :add_info("test.lua", 3, "Info after reset")

      eq(1, qf:count())
      eq("I", qf.items[1].type)
      eq("Info after reset", qf.items[1].text)
    end)

    it("should maintain separate instances", function()
      local qf1 = QuickFixList.new("List 1")
      local qf2 = QuickFixList.new("List 2")

      qf1:add_error("file1.lua", 1, "Error 1")
      qf2:add_warning("file2.lua", 2, "Warning 2")

      eq(1, qf1:count())
      eq(1, qf2:count())
      eq("E", qf1.items[1].type)
      eq("W", qf2.items[1].type)
      eq("List 1", qf1:get_title())
      eq("List 2", qf2:get_title())
    end)
  end)
end)
