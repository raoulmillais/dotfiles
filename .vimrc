" Turn off vi compatibility mode
set nocompatible

" Set 256 color mode
set t_Co=256

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

" Show line numbers
set number

" Highlight matching brackets
set showmatch

" Make backspace work as expected (indent, eol, start)
set backspace=2

" Shorten the large interruptive prompts
set shortmess=atI

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent new lines to same level as last 
set autoindent
" Use nicer whitespace characters and show whitespace
set listchars=tab:>-,trail:-
set list
" Set visible character size of tabstops to 4 and make shift keys 
" shift by 4 characters
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
:let mapleader=","

" Toggle NERDTRee with F2 in command mode
map <f2> :NERDTreeToggle<cr>
" and in insert mode
imap <f2> :NERDTreeToggle<cr>i
" Move line down one
noremap - ddp
" Mappping to allow opening .vimrc in a new vsplit for quick editing
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

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
