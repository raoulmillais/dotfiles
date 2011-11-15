" Turn off vi compatibility mode
set nocompatible

" Set 256 color mode
set t_Co=256

" Default to UTF-8
set encoding=utf-8

" start scrolling 2 lines from screen edge
set scrolloff=2

" Enable syntax highlighting
syntax on
colorscheme zenburn

" Allow vim to manage multiple buffers effectively
set hidden

" Show 80 char column in light grey
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Increase command history size
set history=1000

" Improve tab completion for files and directories to show number of options
set wildmenu
" Make tab completion behave like the shell completing only up to the point of
" ambiguity
set wildmode=list:longest

" Set the window title in the terminal
set title

" Use the matchit macro to enable switching between open close tags and
" if/elsif/else/end with %
runtime macros/matchit.vim

" Show the ruler, incomplete search matches and incomplete commands
set ruler
set showcmd
set incsearch
" Keep search highlight after complete
set hlsearch

" Show line numbers
set relativenumber

" Show the current mode in the last line
set showmode

" Highlight matching brackets
set showmatch

" Remember undo history between opening files
set undofile
set undodir=~/.vim/undo

" Make backspace work as expected (indent, eol, start)
set backspace=2

" Shorten the large interruptive prompts
set shortmess=atI

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automate resizing tabs
" See http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call Stab()

function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

"Shortcut mapping
noremap <leader><tab> :Stab<cr>
" Indent new lines to same level as last
set autoindent
" Use nicer whitespace characters and show whitespace
set listchars=tab:>-,trail:-
set list
" Set visible character size of tabstops to 4 and make shift keys
" shift by 4 characters
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Allow Mouse selection and navigation
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldcolumn=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype indent on
filetype plugin on

" Toggle NERDTRee with F2 in command mode
noremap <f2> :NERDTreeToggle<cr>
" and in insert mode
inoremap <f2> :NERDTreeToggle<cr>i
" Move line down one
nnoremap - ddp
" Open .vimrc in a new split for quick editing
nnoremap <leader>ev :split $MYVIMRC<cr>
" Source .vimrc in current window
nnoremap <leader>sv :source $MYVIMRC<cr>
" Go to start of line
nnoremap H 0
" Go to end of line
nnoremap L $
" Toggle whitespace
noremap <leader>l :set list!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default map overrides
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quicker window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap + <C-w>+
noremap - <C-w>-
nnoremap <leader>w <C-w>s<C-w>j
" Exit insert mode
inoremap jk <esc>
inoremap <esc> <NOP>
inoremap <c-c> <NOP>
" Unmap the arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Unmap the help shortcut key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" Move up and down by screenline instead of file line
nnoremap j gj
nnoremap k gk
" Fix vim's regexp search to use perl regexps
nnoremap / /\v
vnoremap \ /\v
" Move to matching bracket
nnoremap <tab> %
vnoremap <tab> %

" Turn off search highlighting
nnoremap <leader><space> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable saving readonly files with sudo
cmap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gentags config
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,t :!(cd %:p:h;ctags *)&
set tags=./tags,./../tags,./../../tags,./../../../tags,tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands to run on startup
"""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Save on losing focus
autocmd FocusLost * :wa
