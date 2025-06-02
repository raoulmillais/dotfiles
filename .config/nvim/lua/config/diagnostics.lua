local c = require('core')
local keymaps = require('config.keymaps')

c.register_normal_keymaps(keymaps.diagnostics)

--[[
-- These 3 functions push the diagnostic float out of the
-- way of the blink completion menu when its open.
--
-- Sadly, we have to wait for a fix to this bug to be merged:
-- https://github.com/neovim/neovim/issues/31573
-- https://github.com/neovim/neovim/pull/31577/commits/5bb11844b3f73c981c5d090caa07d4f9444fe5c1o
--]]
---@diagnostic disable-next-line: unused-local, unused-function
local function is_blink_menu_open_and_above_cursor()
  local menu_win = require('blink.cmp.completion.windows.menu').win
  if not menu_win then return false end

  local menu_winnr = menu_win:get_win()
  if not menu_winnr then return false end

  local menu_win_config = vim.api.nvim_win_get_config(menu_winnr)
  local cursor_win_row = vim.fn.winline()

  return menu_win_config.row - cursor_win_row < 0
end

---@diagnostic disable-next-line: unused-local, unused-function
local function get_blink_menu_width()
  local menu_win = require('blink.cmp.completion.windows.menu').win
  if not menu_win then return false end

  return menu_win:get_width()
end

---
---@diagnostic disable-next-line: unused-local, unused-function
local function diagnostics_float(_, _)
  local opts = {
    header = "",
    source = true,
    focusable = false,
    anchor_bias = "above",
  }
  if is_blink_menu_open_and_above_cursor() then
    local blink_menu_width = get_blink_menu_width()
    opts.offset_x = blink_menu_width + 1
  end

  return opts
end

vim.diagnostic.config({
  virtual_text = false, -- We show diagnostics in a float
  -- TODO: use `diagnostics_float` instead and turn back on diagnostic float
  -- on CursorHoldI (autocmd)
  float = {
    header = "",
    source = true,
    focusable = false,
    anchor_bias = "above",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    }
  }
})
