local p = require('core.patterns.go')
local lpeg = require('lpeg')
local pegdebug = require('pegdebug')

local function read_fixture()
  local file = io.open("../../fixture/go-test-output.txt", "r")
  if not file then
    error("Could not open fixture file: ../../fixture/go-test-output.txt")
  end
  local content = file:read("*all")
  file:close()
  return content
end

describe("core.patterns.go", function()

  describe("runtime_representation pattern", function()
    it("should match simple runtime representations", function()
      assert.equals(25, p.runtime_representation:match("{0xa76e80, 0xc00017ade0}"))
      assert.equals(17, p.runtime_representation:match("{0xb2de64, 0x4b}"))
      assert.equals(28, p.runtime_representation:match("{0xc000099f28, 0xa1, 0x1f?}"))
    end)

    it("should match runtime representations with question marks", function()
      assert.equals(38, p.runtime_representation:match("{0xc000281300?, 0xc00011fd98?, 0x13?}"))
      assert.equals(42, p.runtime_representation:match("{0xc000281300?, 0xc00011fd98?, 0xf28748?}"))
    end)

    it("should match single address in braces", function()
      assert.equals(15, p.runtime_representation:match("{0xc000103500}"))
      assert.equals(11, p.runtime_representation:match("{0xa3f1a0}"))
    end)

    it("should not match empty braces", function()
      assert.is_nil(p.runtime_representation:match("{}"))
    end)

    it("should not match without braces", function()
      assert.is_nil(p.runtime_representation:match("0xa76e80, 0xc00017ade0"))
    end)

    it("should not match malformed addresses", function()
      assert.is_nil(p.runtime_representation:match("{0xgg, 0x123}"))
      assert.is_nil(p.runtime_representation:match("{invalid}"))
    end)
  end)

  describe("stack_function_arg pattern", function()
    it("should match single addresses", function()
      assert.equals(13, p.stack_function_arg:match("0xc000103500"))
      assert.equals(14, p.stack_function_arg:match("0xc000281300?"))
      assert.equals(9, p.stack_function_arg:match("0xa76e80"))
    end)

    it("should match runtime representations", function()
      assert.equals(25, p.stack_function_arg:match("{0xa76e80, 0xc00017ade0}"))
      assert.equals(38, p.stack_function_arg:match("{0xc000281300?, 0xc00011fd98?, 0x13?}"))
    end)

    it("should not match invalid formats", function()
      assert.is_nil(p.stack_function_arg:match("not_an_address"))
      assert.is_nil(p.stack_function_arg:match("123"))
    end)
  end)

  describe("stack_arg_list pattern", function()
    it("should match single argument", function()
      assert.equals(13, p.stack_arg_list:match("0xc000103500"))
      assert.equals(25, p.stack_arg_list:match("{0xa76e80, 0xc00017ade0}"))
    end)

    it("should match multiple arguments", function()
      assert.equals(39, p.stack_arg_list:match("0xc000103500, {0xa76e80, 0xc00017ade0}"))
      assert.equals(84, p.stack_arg_list:match("{0xc000281300?, 0xc00011fd98?, 0x13?}, {0xb2de64, 0x4}, {0xc000099f28, 0x1a, 0x1e?}"))
    end)

    it("should match complex real-world examples", function()
      -- From the fixture file
      assert.equals(73, p.stack_arg_list:match("{0xc000281300?, 0xc00011fd98?, 0xf28748?}, {0xc000084f28?, 0xf3?, 0x0c?}"))
      assert.equals(39, p.stack_arg_list:match("0xc000103500, {0xa76e80, 0xc00017ade0}"))
    end)

    it("should not match empty list", function()
      assert.is_nil(p.stack_arg_list:match(""))
    end)
  end)

  describe("path_line_offset pattern", function()
    it("should match basic path with line and offset", function()
      local test_input = "        /usr/lib/go/src/runtime/debug/stack.go:26 +0x5e\n"
      assert.equals(#test_input + 1, p.path_line_offset:match(test_input))
    end)

    it("should match paths with varying whitespace", function()
      local test_input = "                /home/raoul/go/pkg/mod/github.com/stretchr/testify@v1.10.0/suite/suite.go:89 +0x37\n"
      assert.equals(#test_input + 1, p.path_line_offset:match(test_input))
    end)

    it("should match short paths", function()
      local test_input = "        /usr/lib/go/src/testing/testing.go:1792 +0xf4\n"
      assert.equals(#test_input + 1, p.path_line_offset:match(test_input))
    end)

    it("should require absolute path", function()
      local test_input = "        relative/path.go:26 +0x5e\n"
      assert.is_nil(p.path_line_offset:match(test_input))
    end)

    it("should require line number", function()
      local test_input = "        /usr/lib/go/src/runtime/debug/stack.go +0x5e\n"
      assert.is_nil(p.path_line_offset:match(test_input))
    end)

    it("should require offset", function()
      local test_input = "        /usr/lib/go/src/runtime/debug/stack.go:26\n"
      assert.is_nil(p.path_line_offset:match(test_input))
    end)
  end)

  describe("stack_start pattern", function()
    it("should match goroutine start lines", function()
      assert.equals(25, p.stack_start:match("goroutine 22 [running]:\n"))
      assert.equals(24, p.stack_start:match("goroutine 1 [running]:\n"))
      assert.equals(25, p.stack_start:match("goroutine 23 [running]:\n"))
      assert.equals(25, p.stack_start:match("goroutine 25 [running]:\n"))
    end)

    it("should handle optional leading whitespace", function()
      assert.equals(29, p.stack_start:match("    goroutine 22 [running]:\n"))
      assert.equals(25, p.stack_start:match("goroutine 22 [running]:\n"))
    end)

    it("should not match other goroutine states", function()
      assert.is_nil(p.stack_start:match("goroutine 22 [waiting]:\n"))
      assert.is_nil(p.stack_start:match("goroutine 22 [sleeping]:\n"))
    end)

    it("should not match without colon", function()
      assert.is_nil(p.stack_start:match("goroutine 22 [running]\n"))
    end)

    it("should not match without newline", function()
      assert.is_nil(p.stack_start:match("goroutine 22 [running]:"))
    end)
  end)

  describe("stack_prelude pattern", function()
    it("should match the runtime debug stack entry", function()
      local test_input = "        runtime/debug.Stack()\n" ..
                        "                /usr/lib/go/src/runtime/debug/stack.go:26 +0x5e\n"
      local debugpat = pegdebug.trace(p.stack_prelude)
      print(lpeg.match(lpeg.P(debugpat), test_input))
      assert.equals(#test_input, p.stack_prelude:match(test_input))
    end)

    it("should handle varying whitespace", function()
      local test_input = "runtime/debug.Stack()\n" ..
                        "        /usr/lib/go/src/runtime/debug/stack.go:26 +0x5e\n"
      assert.equals(#test_input, p.stack_prelude:match(test_input))
    end)

    it("should not match other function names", function()
      local test_input = "        some.other.Function()\n" ..
                        "                /usr/lib/go/src/runtime/debug/stack.go:26 +0x5e\n"
      assert.is_nil(p.stack_prelude:match(test_input))
    end)

    it("should require the path line offset", function()
      local test_input = "        runtime/debug.Stack()\n"
      assert.is_nil(p.stack_prelude:match(test_input))
    end)
  end)



  -- Integration tests using the fixture file
  describe("integration tests with fixture", function()
    local fixture_content

    setup(function()
      fixture_content = read_fixture()
    end)

    it("should find runtime representations in fixture", function()
      local matches = {}
      local pos = 1
      while pos <= #fixture_content do
        local match_end = p.runtime_representation:match(fixture_content, pos)
        if match_end then
          local match = fixture_content:sub(pos, match_end - 1)
          table.insert(matches, match)
          pos = match_end
        else
          pos = pos + 1
        end
      end

      -- Should find several runtime representations
      assert.is_true(#matches > 0)

      -- Check for specific expected matches
      local found_matches = table.concat(matches, " ")
      assert.is_true(found_matches:find("{0xa76e80, 0xc00017ade0}") ~= nil)
      assert.is_true(found_matches:find("{0xc000281300?, 0xc00011fd98?, 0x13?}") ~= nil)
    end)

    it("should find stack start patterns in fixture", function()
      local matches = {}
      local pos = 1
      while pos <= #fixture_content do
        local match_end = p.stack_start:match(fixture_content, pos)
        if match_end then
          local match = fixture_content:sub(pos, match_end - 1)
          table.insert(matches, match)
          pos = match_end
        else
          pos = pos + 1
        end
      end

      -- Should find multiple goroutine starts
      assert.is_true(#matches >= 2)

      -- Check for specific goroutine numbers from fixture
      local found_text = table.concat(matches, " ")
      assert.is_true(found_text:find("goroutine 22") ~= nil)
      assert.is_true(found_text:find("goroutine 25") ~= nil)
    end)

    it("should find stack prelude patterns in fixture", function()
      local matches = {}
      local pos = 1
      while pos <= #fixture_content do
        local match_end = p.stack_prelude:match(fixture_content, pos)
        if match_end then
          local match = fixture_content:sub(pos, match_end - 1)
          table.insert(matches, match)
          pos = match_end
        else
          pos = pos + 1
        end
      end

      -- Should find runtime/debug.Stack entries
      assert.is_true(#matches >= 1)

      -- Should contain the expected runtime debug stack pattern
      local found_text = table.concat(matches, " ")
      assert.is_true(found_text:find("runtime/debug%.Stack%(%)") ~= nil)
      assert.is_true(found_text:find("/usr/lib/go/src/runtime/debug/stack%.go:26") ~= nil)
    end)

    it("should find path line offset patterns in fixture", function()
      local matches = {}
      local pos = 1
      while pos <= #fixture_content do
        local match_end = p.path_line_offset:match(fixture_content, pos)
        if match_end then
          local match = fixture_content:sub(pos, match_end - 1)
          table.insert(matches, match)
          pos = match_end
        else
          pos = pos + 1
        end
      end

      -- Should find multiple path/line/offset patterns
      assert.is_true(#matches > 5)

      -- Check for specific expected paths
      local found_text = table.concat(matches, " ")
      assert.is_true(found_text:find("/usr/lib/go/src/runtime/debug/stack%.go:26") ~= nil)
      assert.is_true(found_text:find("/usr/lib/go/src/testing/testing%.go:1792") ~= nil)
    end)

    it("should validate fixture contains expected test patterns", function()
      -- Sanity check that our fixture contains the expected content
      assert.is_true(fixture_content:find("TestPassing") ~= nil)
      assert.is_true(fixture_content:find("TestFailing") ~= nil)
      assert.is_true(fixture_content:find("TestDatabaseSuite") ~= nil)
      assert.is_true(fixture_content:find("panic.*something terrible happened") ~= nil)
      assert.is_true(fixture_content:find("github%.com/stretchr/testify") ~= nil)
    end)
  end)

  describe("real-world pattern matching", function()
    it("should match typical Go stack trace elements", function()
      -- Test with real examples from the fixture

      -- Runtime representation examples
      assert.truthy(p.runtime_representation:match("{0xa76e80, 0xc00017ade0}"))
      assert.truthy(p.runtime_representation:match("{0xc000281300?, 0xc00011fd98?, 0x13?}"))
      assert.truthy(p.runtime_representation:match("{0xc000084f28?, 0xf4?, 0xe0?}"))

      -- Stack function arg examples
      assert.truthy(p.stack_function_arg:match("0xc000103500"))
      assert.truthy(p.stack_function_arg:match("{0xa3f1a0?, 0xc04460?}"))

      -- Complex argument lists
      assert.truthy(p.stack_arg_list:match("0xc000103500, {0xa76e80, 0xc00017ade0}"))
      assert.truthy(p.stack_arg_list:match("{0xc000281300?, 0xc00011fd98?, 0x13?}, {0xb2de64, 0x4}, {0xc000099f28, 0xb1, 0x1d?}"))
    end)
  end)
end)
