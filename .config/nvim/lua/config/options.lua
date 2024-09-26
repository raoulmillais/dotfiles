local g, opt = vim.g, vim.opt

-- COLORSCHEME {{{1
-- Enable true colors if available
opt.termguicolors = true

-- DIFFING {{{1
opt.diffopt = "vertical"
-- }}}

-- SEARCHING {{{1
opt.grepprg = "rg --no-heading --vimgrep"
-- }}}

-- BASICS {{{1
opt.exrc = true -- Allow current working directory vim configs
opt.errorbells = false -- No annoying beeps
opt.history = 1000 -- Increase command history size
opt.incsearch = true -- Incomplete search matches
opt.inccommand = 'split' -- neovim special
opt.hlsearch = true -- Keep search highlight after complete
-- TODO: Figure out a lua "native" way of doing this
vim.cmd [[set t_Co=256]] -- Set 256 color mode
opt.encoding = "utf-8" -- Default to UTF-8
opt.scrolloff = 2 -- start scrolling 2 lines from screen edge
opt.hidden = true -- Hide rather than close abandoned buffers
opt.backspace = { "indent", "eol", "start" } -- Make backspace work for indent, eol, start
opt.ttyfast = true -- Smoother redrawing with multiple windows
opt.report = 0 -- Always tell me how many lines were affected
opt.completeopt = { "menuone" } -- Show menu even for one item and no preview
opt.mouse = "nv" -- Allow Mouse in normal and visual mode
opt.iskeyword:append "-" -- Consider hypenated words as one word
opt.path:append "**" -- Look for files in subdirectories of current
-- directory. This gives fuzzy finding with tab
-- completions for :edit :write commands etc
-- }}}

-- STATUS LINE {{{1
opt.showmode = true -- Show the current mode in the last line
opt.showcmd = true -- Show the current command in the last line
opt.ruler = true -- Show the line and column of the cursor position
-- }}}

-- WILDMENU {{{1
opt.wildmode = "full" -- Tab complete longest common string and show list
opt.wildoptions = "pum" -- Show wildmenu in pop up menu
opt.wildignore = opt.wildignore + { ".git", ".hg", ".svn" } -- Version control
opt.wildignore = opt.wildignore + { "*.aux", "*.out", "*.toc" } -- LaTeX intermediate files
opt.wildignore = opt.wildignore + { "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg" }
-- compiled object files
opt.wildignore = opt.wildignore + { "*.o", "*.obj", "*.exe", "*.dll", "*.manifest" }
opt.wildignore = opt.wildignore + { "*.sw?" } -- Vim swap files
opt.wildignore = opt.wildignore + { "*.node" } -- Node compiled addons
opt.wildignore = opt.wildignore + { "*/node_modules/*" } -- Node project modules source
opt.wildignore = opt.wildignore + { "*/coverage/*" } -- Code coverage files
opt.wildignore = opt.wildignore + { "*/.sass-cache/*" } -- Code coverage files
-- }}}

-- AUTO READ & WRITE {{{1
opt.autoread = true -- Autoreload buffers that have changed on disk
opt.autowrite = true -- Autowrite files when leaving
opt.autowriteall = true -- Autowrite files for all commands
-- }}}

-- BRACKET MATCHING {{{1
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 3 -- Jump to matching paren for a briefer time
-- }}}

-- MESSAGES {{{1
opt.shortmess = "atIc" -- Shorten the large interruptive prompts
opt.cmdheight = 2 -- Allow a bit more room for messages
-- }}}

-- GUTTER {{{1
opt.number = true -- Shows the current line in gutter instead of `0`
opt.relativenumber = true -- Show line numbers relative to current in gutter
opt.signcolumn = "yes" -- Always show the sign colum
-- }}}

-- SPELLING {{{1
opt.dictionary = "/usr/share/dict/words" -- The arch linux `words` package
opt.spelllang = "en_gb" -- British English
-- }}}

-- SPLITS {{{1
opt.splitbelow = true -- Open new splits below current window
opt.splitright = true -- Open new vsplits to the right
-- }}}

-- CURSOR SETTINGS {{{1
-- Defaults for new windows
opt.cursorline = true -- Highlight the line under the cursor
opt.cursorcolumn = false -- Don't Highlight the column

opt.smoothscroll = true
opt.smartindent = true

-- Toggle on focus
local group = vim.api.nvim_create_augroup("CursorLineFocus", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")
-- }}}

-- COLOR COLUMN SETTINGS {{{1
-- Show 80 char column in light grey
opt.colorcolumn = "80"
vim.cmd [[highlight ColorColumn ctermbg=239 guibg=#4f4f4f]]

-- Disable colorcolumn in the quickfix buffers
-- TODO: convert this autocommand to use the lua API
vim.cmd [[au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap]]
-- }}}

-- BACKUPS, UNDO AND SWAPFILES {{{1
opt.undofile = true
opt.updatecount = 50 -- save the files sooner than the default (after 50 chars)
-- triggers the CursorHold event sooner than the default 4s
-- (makes coc feel more responsive)
opt.updatetime = 300
-- }}}

-- TABS AND WHITESPACE{{{1
opt.cindent = true -- Indent new lines to same level as last
opt.listchars = { tab = "▸▸", space = "·" } -- Nicer whitespace characters
opt.list = true -- Show whitespace
opt.softtabstop = 2 -- 2 spaces is a tab when editing/inserting
opt.tabstop = 2 -- 2 spaces is equivalent to a tab
opt.shiftwidth = 2 -- Shift by 2 spaces
opt.expandtab = true -- Expand tab to spaces
-- }}}

-- FOLDING {{{1
opt.foldlevelstart = 99 -- Open all folds
opt.foldcolumn = "3" -- Show 3 levels
opt.foldmethod = "marker"
-- }}}

-- KEYMAPS {{{1
g.mapleader = ","
g.maplocalleader = ","
-- }}}

-- SEXP {{{1
vim.g.sexp_enable_insert_mode_mappings = 0
-- }}}
--
