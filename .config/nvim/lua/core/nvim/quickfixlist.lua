---@class QuickFixList
---@field title string The title of the quickfix list
---@field items table[] Array of quickfix items
local QuickFixList = {}
QuickFixList.__index = QuickFixList

---Create a new QuickFixList instance
---@param title? string Optional title for the quickfix list (default: 'Custom Results')
---@return QuickFixList
function QuickFixList.new(title)
    local self = setmetatable({}, QuickFixList)
    self.title = title or 'Custom Results'
    self.items = {}
    self:reset()
    return self
end

---Reset the quickfix list, clearing all items
---@return QuickFixList self for method chaining
function QuickFixList:reset()
    vim.fn.setqflist({}, 'r', {title = self.title})
    self.items = {}
    return self
end

---Add an item to the quickfix list
---@param file string Path to the file
---@param line integer Line number (1-indexed)
---@param text string Description text for the item
---@param type? string Item type: 'E' (error), 'W' (warning), 'I' (info), 'N' (note). Default: 'I'
---@param col? integer Column number (1-indexed). Default: 1
---@return QuickFixList self for method chaining
function QuickFixList:add(file, line, text, type, col)
    local item = {
        filename = file,
        lnum = line,
        text = text,
        type = type or 'I',
        col = col or 1
    }

    table.insert(self.items, item)
    vim.fn.setqflist({item}, 'a')
    return self
end

---Add an error item to the quickfix list
---@param file string Path to the file
---@param line integer Line number (1-indexed)
---@param text string Error description
---@param col? integer Column number (1-indexed). Default: 1
---@return QuickFixList self for method chaining
function QuickFixList:add_error(file, line, text, col)
    return self:add(file, line, text, 'E', col)
end

---Add a warning item to the quickfix list
---@param file string Path to the file
---@param line integer Line number (1-indexed)
---@param text string Warning description
---@param col? integer Column number (1-indexed). Default: 1
---@return QuickFixList self for method chaining
function QuickFixList:add_warning(file, line, text, col)
    return self:add(file, line, text, 'W', col)
end

---Add an info item to the quickfix list
---@param file string Path to the file
---@param line integer Line number (1-indexed)
---@param text string Info description
---@param col? integer Column number (1-indexed). Default: 1
---@return QuickFixList self for method chaining
function QuickFixList:add_info(file, line, text, col)
    return self:add(file, line, text, 'I', col)
end

---Add a note item to the quickfix list
---@param file string Path to the file
---@param line integer Line number (1-indexed)
---@param text string Note description
---@param col? integer Column number (1-indexed). Default: 1
---@return QuickFixList self for method chaining
function QuickFixList:add_note(file, line, text, col)
    return self:add(file, line, text, 'N', col)
end

---Open the quickfix window
---@return QuickFixList self for method chaining
function QuickFixList:open()
    vim.cmd('copen')
    return self
end

---Close the quickfix window
---@return QuickFixList self for method chaining
function QuickFixList:close()
    vim.cmd('cclose')
    return self
end

---Get the number of items in the quickfix list
---@return integer count The number of items
function QuickFixList:count()
    return #self.items
end

---Check if the quickfix list is empty
---@return boolean empty True if the list has no items
function QuickFixList:is_empty()
    return #self.items == 0
end

---Get all items in the quickfix list
---@return table[] items Array of quickfix items
function QuickFixList:get_items()
    return vim.deepcopy(self.items)
end

---Set a new title for the quickfix list
---@param title string New title for the quickfix list
---@return QuickFixList self for method chaining
function QuickFixList:set_title(title)
    self.title = title
    vim.fn.setqflist({}, 'a', {title = self.title})
    return self
end

---Get the current title of the quickfix list
---@return string title The current title
function QuickFixList:get_title()
    return self.title
end

return QuickFixList
