local ok, Job = pcall(require, "plenary.job")
if not ok then
  return
end

local source = {}

source.new = function ()
  local self = setmetatable({ cache = {} }, { __index = source })

  return self
end

source.complete = function (self, _, callback)
  local bufnr = vim.api.nvim_get_current_buf()
  -- Return cached result if we've already got items
  if self.cache[bufnr] then
    callback { items = self.cache[bufnr], isIncomplete = false }
    return
  end

  Job:new({
    "gh", "issue", "list", "--limit", "1000", "--json", "title,number,body",
    on_exit = function(job)
      local result = job:result()
      local decoded, parsed = pcall(vim.json.decode, table.concat(result, ""))
      if not decoded then
        --TODO figure ot how to log in aplenary jo
        --vim.notify "Failed to parse gh result"
        return
      end

      local items = {}
      for _, item in ipairs(parsed) do
        item.body = string.gsub(item.body or "", "\r", "")

        table.insert(items, {
          label = string.format("#%s", item.number),
          documentation = {
            kind = "markdown",
            value =  string.format("# %s\n\n%s", item.title, item.bod)
          }
        })
      end

      self.cache[bufnr] = items
      callback { items = items, isIncomplete = false }
    end}):start()
end

source.get_trigger_characters = function()
  return { '#' }
end
require("cmp").register_source("gh_issues", source.new())
