local c = require('core')
local g, opt = vim.g, vim.opt

-- COLORSCHEME
opt.termguicolors = true
c.hl(0, 'NormalFloat', { bg = '#1d2021' })

-- DIFFING
opt.diffopt = "vertical"

-- SEARCHING
opt.grepprg = "rg --no-heading --vimgrep"

-- BASICS
opt.exrc = true -- Allow current working directory vim configs
opt.errorbells = false -- No annoying beeps
opt.history = 1000 -- Increase command history size
opt.incsearch = true -- Incomplete search matches
opt.inccommand = 'split' -- neovim special
opt.hlsearch = true -- Keep search highlight after complete
opt.encoding = "utf-8" -- Default to UTF-8
opt.scrolloff = 2 -- start scrolling 2 lines from screen edge
opt.hidden = true -- Hide rather than close abandoned buffers
opt.backspace = { "indent", "eol", "start" } -- Make backspace work for indent, eol, start
opt.ttyfast = true -- Smoother redrawing with multiple windows
opt.report = 0 -- Always tell me how many lines were affected
opt.completeopt = { "menuone" } -- Show menu even for one item and no preview
opt.mouse = "nv" -- Allow Mouse in normal and visual mode
---@diagnostic disable-next-line: undefined-field
opt.iskeyword:append "-" -- Consider hypenated words as one word
opt.title = true -- Sets the terminal window title
opt.path:append "**" -- Look for files in subdirectories of current directory
opt.winborder = "rounded" -- Rounded borders on floating windows

-- STATUS LINE
opt.showmode = true -- Show the current mode in the last line
opt.showcmd = true -- Show the current command in the last line
opt.ruler = true -- Show the line and column of the cursor position
opt.laststatus = 2 -- Taller status line to reduce annoying prompts
opt.fillchars = { stl = "─" }
c.hl(0, 'StatusLine', { fg = '#665c54', bg = '#1d2021' })


-- WILDMENU
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

-- AUTO READ & WRITE
opt.autoread = true -- Autoreload buffers that have changed on disk
opt.autowrite = true -- Autowrite files when leaving
opt.autowriteall = true -- Autowrite files for all commands

-- BRACKET MATCHING
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 3 -- Jump to matching paren for a briefer time

-- MESSAGES
opt.shortmess = "atIc" -- Shorten the large interruptive prompts
opt.cmdheight = 2 -- Allow a bit more room for messages

-- GUTTER
opt.number = true -- Shows the current line in gutter instead of `0`
opt.relativenumber = true -- Show line numbers relative to current in gutter
opt.signcolumn = "yes" -- Always show the sign colum

-- SPELLING
opt.dictionary = "/usr/share/dict/words" -- The arch linux `words` package
opt.spelllang = "en_gb" -- British English

-- SPLITS
opt.splitbelow = true -- Open new splits below current window
opt.splitright = true -- Open new vsplits to the right

-- CURSOR SETTINGS
-- Defaults for new windows
opt.cursorline = true -- Highlight the line under the cursor
opt.cursorcolumn = false -- Don't Highlight the column

-- Show 80 char column in light grey
opt.colorcolumn = "80" -- Show a guide at 80 chars
c.hl(0, 'ColorColumn', { bg="#4f4f4f" })

-- override the colorscheme and make fold and sign columns same as
-- normal bg color
c.hl(0, 'FoldColumn', { bg="#1d2021" })
c.hl(0, 'SignColumn', { bg="#1d2021" })

opt.smoothscroll = true
opt.smartindent = true

-- BACKUPS, UNDO AND SWAPFILES
opt.undofile = true
opt.updatecount = 50 -- save the files sooner than the default (after 50 chars)
opt.updatetime = 250

-- TABS AND WHITESPACE
opt.cindent = true -- Indent new lines to same level as last
opt.listchars = { tab = "▸▸", space = "·" } -- Nicer whitespace characters
opt.list = true -- Show whitespace
opt.softtabstop = 2 -- 2 spaces is a tab when editing/inserting
opt.tabstop = 2 -- 2 spaces is equivalent to a tab
opt.shiftwidth = 2 -- Shift by 2 spaces
opt.expandtab = true -- Expand tab to spaces

-- FOLDING
opt.foldlevelstart = 99 -- Open all folds
opt.foldcolumn = "3" -- Show 3 levels
opt.foldmethod = "marker"

-- KEYMAPS
g.mapleader = ","
g.maplocalleader = ","

-- SEXP (For lisps)
vim.g.sexp_enable_insert_mode_mappings = 0
