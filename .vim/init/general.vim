vim9script noclear

# FILETYPE & SYNTAX HIGHLIGHTING {{{1
###############################################################################
# These are set by vim-plug automatically
# set filetype on          " Autodetect filetypes
# set filetype indent on   " Enable loading the indent file for specific filetypes
# set filetype plugin on   " Enable loading plugins for specific filetypes
# syntax on            " Enable syntax highlighting
# }}}

# COLORSCHEME {{{1
###############################################################################
&t_8f = "\<Esc>[38;2;%lu;%lu;%lum"   # Fix colors for tmux
&t_8b = "\<Esc>[48;2;%lu;%lu;%lum"   # https://github.com/tmux/tmux/issues/1246
# Enable true colors if available
set termguicolors
set background=dark                  # Dark colorscheme please
g:gruvbox_italic = 1                   # Alacritty supports italics just fine
g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
# Enable italics, Make sure this is immediately after colorscheme
# https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
highlight Comment cterm=italic gui=italic
# }}}

# DIFFING {{{1
###############################################################################
set diffopt=vertical
# }}}

# SEARCHING {{{1
###############################################################################
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m
# }}}

# GUI {{{1
###############################################################################
set guioptions-=T         # Remove GUI toolbar
set guioptions-=e         # Use text tab bar, not GUI
set guioptions-=rL        # Remove scrollbars
set guioptions-=m         # Remove menu bar
# }}}

# BASICS {{{1
###############################################################################
set noerrorbells          # No annoying beeps
set visualbell t_vb=
set history=1000          # Increase command history size
set incsearch             # Incomplete search matches
set hlsearch              # Keep search highlight after complete
set t_Co=256              # Set 256 color mode
set encoding=utf-8        # Default to UTF-8
set scrolloff=2           # start scrolling 2 lines from screen edge
set hidden                # Hide rather than close abandoned buffers
set backspace=2           # Make backspace work for indent, eol, start
set ttyfast               # Smoother redrawing with multiple windows
set lazyredraw            # Suspend redrawing while running macros
set report=0              # Always tell me how many lines were affected
set completeopt=menuone   # Show menu even for one item and no preview
set mouse=nv              # Allow Mouse in normal and visual mode
set iskeyword+=-          # Consider hypenated words as one word
set path+=**              # Look for files in subdirectories of current 
                          # directory. This gives fuzzy finding with tab
                          # completions for :edit :write commands etc
# }}}

# STATUS LINE {{{1
###############################################################################
set showmode              # Show the current mode in the last line
set showcmd               # Show the current command in the last line
set ruler                 # Show the line and column of the cursor position
# }}}

# WILDMENU {{{1
###############################################################################
set wildmenu              # Improve tab completion menu
set wildmode=full         # Tab complete longest common string and show list
set wildoptions=pum       # Show wildmenu in pop up menu
set wildignore+=.git,.hg,.svn                    # Version control
set wildignore+=*.aux,*.out,*.toc                # LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   # binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest # compiled object files
set wildignore+=*.sw?                            # Vim swap files
set wildignore+=*.node                           # Node compiled addons
set wildignore+=*/node_modules/*                 # Node project modules source
set wildignore+=*/coverage/*                     # Code coverage files
set wildignore+=*/.sass-cache/*                  # Code coverage files
# }}}

# AUTO READ & WRITE {{{1
###############################################################################
set autoread              # Autoreload buffers that have changed on disk
set autowrite             # Autowrite files when leaving
set autowriteall          # Autowrite files for all commands
# }}}

# BRACKET MATCHING {{{1
###############################################################################
set showmatch             # Highlight matching brackets
set matchtime=3           # Jump to matching paren for a briefer time
# }}}

# MESSAGES {{{1
###############################################################################
set shortmess=atIc        # Shorten the large interruptive prompts
set cmdheight=2           # Allow a bit more room for messages
# }}}

# GUTTER {{{1
###############################################################################
set number                # Shows the current line in gutter instead of `0`
set relativenumber        # Show line numbers relative to current in gutter
set signcolumn=yes        # Always show the sign colum
# }}}

# SPELLING {{{1
###############################################################################
set dictionary=/usr/share/dict/words # The arch linux `words` package is here
set spelllang=en_gb                  # Force the language to British English
# }}}

# SPLITS {{{1
###############################################################################
set splitbelow            # Open new splits below current window
set splitright            # Open new vsplits to the right
# }}}

# CURSOR SETTINGS {{{1
###############################################################################
# Defaults for new windows
set cursorline                       # Highlight the line under the cursor
set nocursorcolumn                   # Don't Highlight the column
# Toggle on focus
au WinEnter * setlocal cursorline    # Turn on cursorline on focus
au WinLeave * setlocal nocursorline  # And off on losing focus
# }}}

# COLOR COLUMN SETTINGS {{{1
###############################################################################
# Show 80 char column in light grey
set colorcolumn=80
highlight ColorColumn ctermbg=239 guibg=#4f4f4f

# Disable colorcolumn in the quickfix buffers
au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap
# }}}

# BACKUPS, UNDO AND SWAPFILES {{{1
###############################################################################
set undofile
set undodir=~/.vim/tmp/undo,~/tmp,/tmp
set backupdir=~/.vim/tmp/backup,~/tmp,/tmp
set directory=~/.vim/tmp/swap/,~/tmp,/tmp
set updatecount=50 # save the files sooner than the default (after 50 chars)
# triggers the CursorHold event sooner than the default 4s
# (makes coc feel more responsive)
set updatetime=300
# }}}

# TABS AND WHITESPACE{{{1
###############################################################################
set cindent                         # Indent new lines to same level as last
set listchars=tab:▸▸,space:·        # Nicer whitespace characters
set list                            # Show whitespace
set softtabstop=2                   # 2 spaces is a tab when editing/inserting
set tabstop=2                       # 2 spaces is equivalent to a tab
set shiftwidth=2                    # Shift by 2 spaces
set expandtab                       # Expand tab to spaces
# }}}

# FOLDING {{{1
###############################################################################
# FIXME: move to autoload
def SimpleFoldText(): string
  return getline(v:foldstart) .. ' '
enddef

set foldlevelstart=99               # Open all folds
set foldcolumn=3                    # Show 3 levels
set foldtext=SimpleFoldText()       # Only the function name
# }}}

# KEYMAPS {{{1
###############################################################################
g:mapleader = ","
g:maplocalleader = ","
# }}}

# PROJECT LEVEL VIMRCS {{{1
###############################################################################
set exrc
set secure
# }}}
