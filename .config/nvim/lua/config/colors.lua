local palette = require('gruvbox').palette

local extra_bright_orange = '#ffaf00'
local tab_bar_background = '#0f1112'

return {
  -- Don't make the left gutter stand out from the buffer
  FoldColumn = { bg = palette.dark0_hard },
  SignColumn = { bg = palette.dark0_hard },
  -- This is the heading above neo-tree added by bufferline, I want it
  -- to match the rest of the background of bufferline. This is not a
  -- gruvbox dark colour but it works nicely
  Directory = { bg = tab_bar_background },
  NeoTreeDirectoryIcon = { fg= extra_bright_orange },
  NeoTreeDirectoryName = { fg= extra_bright_orange },
  NeoTreeFileIcon = { fg = palette.gray },
  NeoTreeFileName = { fg = palette.gray },
  TelescopeSelection = { fg = extra_bright_orange, bg = palette.dark0 },
  TelescopePromptTitle = { fg = palette.light1, italic = true, bold = true },
  TelescopePromptPrefix = { fg = palette.neutral_blue, bold = true },
  TelescopeSelectionCaret = { fg = extra_bright_orange, bold = true },
  DiagnosticSignError = { fg = palette.neutral_red, bg = palette.dark0_hard },
  DiagnosticSignWarn = { fg = palette.neutral_yellow, bg = palette.dark0_hard },
  DiagnosticSignInfo = { fg = palette.neutral_aqua, bg = palette.dark0_hard },
  DiagnosticSignHint = { bg = palette.dark0_hard },
  -- Make column and cursor guides really subtle
  ColorColumn = { bg = palette.dark0 },
  CursorLine = { bg = palette.dark0 },
  CursorLineNr = { bg = palette.dark0 },
  -- Don't make the floats standout - they already have a border
  NormalFloat = { bg = palette.dark0_hard },
  Search = { bg = palette.dark4, fg= palette.dark0_hard },
  -- There is an autocmd to change the StatusLine hilight in insert mode
  StatusLine = { fg = palette.neutral_blue, bg = palette.dark0_hard }, --Normal mode
  StatusLineNC = { fg = palette.dark3, bg = palette.dark0_hard }, -- Unfocussed
  Comment = { fg = palette.dark2 }, -- darker but still legible
  -- Match the status line in insert mode (this is the "-- INSERT --" message)
  ModeMsg = { fg= extra_bright_orange, bold = true },
  -- Much less alarming error messages but still red
  ErrorMsg = { fg = palette.neutral_red, bg = palette.dark0_hard, bold = false },
}
