local c = require('core')
local opt = vim.opt

-- Disable paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = c.augroup("disable_paste"),
  pattern = "*",
  callback = function()
    opt.paste = false
  end,
})
-- Automatically rebalance windows on vim resize
vim.api.nvim_create_autocmd("VimResized", {
  group = c.augroup("resize_splits"),
  pattern = "*",
  command = "wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
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
vim.api.nvim_create_autocmd("BufReadPost", {
  group = c.augroup("last_location"),
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

opt.laststatus = 2 -- Taller status line to reduce annoying prompts
vim.api.nvim_create_autocmd("InsertEnter", {
  group = c.augroup("status_line_colors"),
  pattern = "*",
  command = "hi StatusLine ctermfg=214 guifg=#FFAF00",
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = c.augroup("status_line_colors"),
  pattern = "*",
  command = "hi StatusLine ctermfg=236 guifg=#CD5907",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = c.augroup("remove_trailing_whitespace"),
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- TODO: These should be set as a buffer local in ftplugins
vim.api.nvim_create_autocmd("FileType", {
  group = c.augroup("set_make_tab_settings"),
  pattern = "make",
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.shiftwidth = 8
  end,
})

vim.api.nvim_create_autocmd("FileType",{
  group = c.augroup("rust_cargo_run_on_F5"),
  pattern = "rust",
  callback = function()
    vim.opt_local.makeprg = "cargo run"
      c.nmap("<F5>", ":make<cr>")
  end,
})
