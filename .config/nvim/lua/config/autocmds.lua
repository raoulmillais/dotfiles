local c = require('core')
local opt = vim.opt

-- Disable paste mode when leaving insert mode
c.autocmd("InsertLeave", {
  group = c.augroup("disable_paste"),
  pattern = "*",
  callback = function()
    opt.paste = false
  end,
})
-- Automatically rebalance windows on vim resize
c.autocmd("VimResized", {
  group = c.augroup("resize_splits"),
  pattern = "*",
  command = "wincmd =",
})

c.autocmd("FileType", {
  group = c.augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "grug-far",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns.blame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

-- go to last loc when opening a buffer (Adapted from LazyVim)
c.autocmd("BufReadPost", {
  group = c.augroup("restore_last_location"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].raoulmillais_last_location then
      return
    end
    vim.b[buf].raoulmillais_last_location = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

c.autocmd({ "InsertEnter", "InsertLeave" }, {
  group = c.augroup("status_line_colors"),
  pattern = "*",
  callback = function(event)
    if event.event == 'InsertEnter' then
      -- Orange in insert mode
      c.hl(0, 'StatusLine', { fg = '#ffaf00', bg = '#1d2021' })
    else
      -- Blue
      c.hl(0, 'StatusLine', { fg = '#458588', bg = '#1d2021' })
    end
  end
})

c.autocmd({ "BufWritePre" }, {
  group = c.augroup("remove_trailing_whitespace"),
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})


local set_cursorline = function(event, value, pattern)
  c.autocmd(event, {
    group = c.augroup("toggle_cursor_line_on_focus"),
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

c.autocmd("FileType", {
  group = c.augroup("disable_guides_in_quickfix"),
  pattern = "qf",
  callback = function()
    vim.opt_local.colorcolumn = "0"
    vim.opt_local.list = false
    vim.opt_local.cursorline = false
    vim.opt_local.wrap = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
  end
})

c.autocmd("FileType", {
  group = c.augroup("help_in_vertical_split"),
  pattern = "help",
  callback = function ()
    -- Help buffers are large and readonly and easily recretaed so free up some
    -- RAM and declutter the buffer list by unloading them when they are closed
    vim.opt_local.bufhidden="unload"
    -- Put the help buffer in an 80 column vertical split
    vim.api.nvim_command("wincmd L | vertical resize 80")
    -- Remove all the unnecessary buffer decorations
    vim.opt_local.ruler = false
    vim.opt_local.statuscolumn = ""
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
  end
})

--TODO: Add CursorHoldI back in when bug is fixed (see diagnostics.lua)
c.autocmd({"CursorHold"}, {
  group = c.augroup("diagnostics_in_float"),
  pattern = "*",
  callback = function ()
    vim.diagnostic.open_float()
  end
})

local opts = { noremap = true, silent = true }
c.autocmd('LspAttach', {
  group = c.augroup("attach_lsp_keybinds"),
  callback = function (args)
    local keymaps = require('config.keymaps')
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    for _, km in pairs(keymaps.lsp) do
      local lhs, rhs, o = unpack(km)
      c.merge(o, opts)
      c.nmap_buf(bufnr, lhs, rhs, o)
    end
    if client and client:supports_method 'textDocument/inlayHint' then
      if
        vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == ""
      then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    if client and client:supports_method 'textDocument/codeLens' then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end
})
