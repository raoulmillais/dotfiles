local opt = vim.opt
-- AUTOMATION {{{1
-- Disable paste mode when leaving insert mode
local group = vim.api.nvim_create_augroup("GlobalAutomation", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  pattern = "*",
  callback = function()
    opt.paste = false
  end,
})
-- Automatically rebalance windows on vim resize
vim.api.nvim_create_autocmd("VimResized", {
  group = group,
  pattern = "*",
  command = "wincmd =",
})
-- }}}

-- STATUS LINE {{{1
opt.laststatus = 2 -- Taller status line to reduce annoying prompts
local sl_group = vim.api.nvim_create_augroup("StatusLineActiveColorToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = sl_group,
  pattern = "*",
  command = "hi StatusLine ctermfg=214 guifg=#FFAF00",
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = sl_group,
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
