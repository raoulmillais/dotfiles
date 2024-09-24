local opt = vim.opt
local function augroup(name)
  return vim.api.nvim_create_augroup("raoulmillais_" .. name, { clear = true })
end

-- AUTOMATION {{{1
-- Disable paste mode when leaving insert mode
local group = vim.api.nvim_create_augroup("GlobalAutomation", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup("disable_paste"),
  pattern = "*",
  callback = function()
    opt.paste = false
  end,
})
-- Automatically rebalance windows on vim resize
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  pattern = "*",
  command = "wincmd =",
})
-- }}}

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
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
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_location"),
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

-- STATUS LINE {{{1
opt.laststatus = 2 -- Taller status line to reduce annoying prompts
local sl_group = vim.api.nvim_create_augroup("StatusLineActiveColorToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup("status_line_colors"),
  pattern = "*",
  command = "hi StatusLine ctermfg=214 guifg=#FFAF00",
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup("status_line_colors"),
  pattern = "*",
  command = "hi StatusLine ctermfg=236 guifg=#CD5907",
})
-- }}}

-- GENERAL {{{1
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  pattern = "*",
  command = "wincmd p",
})
-- TODO: This should be set as a buffer local option in an ftplugin
vim.api.nvim_create_autocmd("FileType", {
  group = sl_group,
  pattern = "make",
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.shiftwidth = 8
  end,
})
-- }}}

vim.api.nvim_create_autocmd("FileType",{
  group = group,
  pattern = "rust",
  callback = function()
    vim.opt_local.makeprg = "cargo run"
      nmap("<F5>", ":make<cr>")
  end,
})
