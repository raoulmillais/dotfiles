" Turn off vi compatibility mode
set nocompatible

" Set 256 color mode
set t_Co=256

" start scrollign 2 lines from screen edge
set so=2

" Enable syntax highlighting
syntax on
colorscheme zenburn

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

" Mouse
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable saving readonly files with sudo
cmap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gentags config
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,t :!(cd %:p:h;ctags *)&
set tags=./tags,./../tags,./../../tags,./../../../tags,tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands to run on startup
"""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
