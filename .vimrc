" Philosophy
"
" * Strives for as much config as necessary but no more.  Adding more
" configuration makes issues harder to diagnose
" * This vimrc is not designed to be portable it assumes the latest stable 
" gvim package (from arch linux) - E.g. it don't defensively check for features
" * Only change from default settings for the smallest scope possible. E.g 
"   * if a setting can be effective when it only applies to a single filetype then
"   don't make the setting global
"   * prefer configuring coc in the coc-settings.json to here (we want this
"   file as small as possible)
"

"
" Bootstrap plugins and filetypes 
"
set nocompatible  " Turn off vi compatibility mode filetype off 
                  " Interferes with Vundle plugin loading

call plug#begin('~/.vim/plugged')

Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-prettier'
Plug 'neoclide/coc-eslint'
Plug 'othree/yajs.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-scripts/scratch.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'vifm/vifm.vim'
Plug 'cespare/vim-toml'
Plug 'eraserhd/parinfer-rust',                     {'for': 'clojure'}
Plug 'guns/vim-sexp',                              {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'liquidz/vim-iced',                           {'for': 'clojure'}
Plug 'liquidz/vim-iced-coc-source',                {'for': 'clojure'}
" TODO: move from NERDTree to fern instead of having both?  NERDTree plays nice 
" with devicons and I know all the mappings but the iced debugger wants fern
Plug 'lambdalisue/fern.vim' 
Plug 'liquidz/vim-iced-fern-debugger',             {'for': 'clojure'}
" Must come last
Plug 'ryanoasis/vim-devicons'

call plug#end()

filetype on                 " Reenable filetype
filetype indent on
filetype plugin on

" }}}
" Colorscheme {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                                " Enable syntax highlighting
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"   " Fix colors for tmux
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"   " https://github.com/tmux/tmux/issues/1246
" Enable true colors if available
set termguicolors
set background=dark                      " Dark colorscheme please
let g:gruvbox_italic=1                   " KiTTY supports italics just fine
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox
" Enable italics, Make sure this is immediately after colorscheme
" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
highlight Comment cterm=italic gui=italic

" }}}
" Diffing {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set diffopt=vertical
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	\ | wincmd p | diffthis


" }}}
" Search mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clobber S with fast global search and replace
nmap S :%s::g<LEFT><LEFT>
" Clobber M with mapping to replace all last search
nmap <expr> M  ':%s/' . @/ . '//g<LEFT><LEFT>' "

" }}}
" Make targets {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :make build<BAR>copen<CR>
nnoremap <F6> :make test<BAR>copen<CR>

" }}}
" Coc {{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Easier to type :Prettier command that uses coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

nmap <leader>cr <Plug>(coc-rename)
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>cy <Plug>(coc-type-definition)
nmap <leader>cR <Plug>(coc-references)
nmap <leader>ca :CocAction<cr>
nmap <leader>cD :CocDiagnostics<cr>

" Format document
vmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" This matches the vim-unimpaired key bindings
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" }}}
" Vimux {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
" enter vimux pane in copymode (same as entering and typing <C-[>)
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vc :VimuxCloseRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" }}}
" Iced (clojure) {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:iced_enable_default_key_mappings = v:true
let g:iced#debug#debugger = 'fern'
let g:sexp_enable_insert_mode_mappings = 0

" }}}
" Golang {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>gb  :GoBuild<CR>
nnoremap <Leader>gd  :GoDoc<CR>
nnoremap <Leader>gi  :GoInfo<CR>
nnoremap <Leader>grn :GoRename<CR>
nnoremap <Leader>gre :GoReferrers<CR>
nnoremap <Leader>gtd :GoDef<CR>
nnoremap <Leader>gta :GolangTestCurrentPackage<CR>
nnoremap <Leader>gtf :GolangTestFocused<CR>
nnoremap <Leader>gcc :GoCoverageToggle!<CR>

" }}}
" Searching {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m

" }}}
" fzf {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/bundle/fzf.vim/bin/preview.sh {}']}, <bang>0)
nnoremap <C-p> :GFiles<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" }}}
" Notes {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:notes_directories = ['~/Notes']

" }}}
" Bundled plugins {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the matchit macro to enable switching between open close tags and
" if/elsif/else/end with %
runtime macros/matchit.vim
runtime ftplugin/man.vim  " Enable viewing man pages


" }}}
" Basic stuff {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noerrorbells          " No annoying beeps
set visualbell t_vb=
set history=1000          " Increase command history size
set incsearch             " Incomplete search matches
set hlsearch              " Keep search highlight after complete
set relativenumber        " Show line numbers
set showmode              " Show the current mode in the last line
set showcmd               " Show the current command in the last line
set showmatch             " Highlight matching brackets
set wildmenu              " Improve tab completion menu
set wildmode=full         " Tab complete longest common string and show list
set t_Co=256              " Set 256 color mode
set wildignore+=.git,.hg,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.node                           " Node compiled addons
set wildignore+=*/node_modules/*                 " Node project modules source
set wildignore+=*/coverage/*                     " Code coverage files
set wildignore+=*/.sass-cache/*                     " Code coverage files
set encoding=utf-8        " Default to UTF-8
set scrolloff=2           " start scrolling 2 lines from screen edge
set hidden                " Hide rather than close abandoned buffers
set backspace=2           " Make backspace work for indent, eol, start
set shortmess=atIc        " Shorten the large interruptive prompts
set ttyfast               " Smoother redrawing with multiple windows
set lazyredraw            " Suspend redrawing while running macros
set matchtime=3           " Jump to matching paren for a briefer time
set splitbelow            " Open new splits below current window
set splitright            " Open new vsplits to the right
set autowrite             " Autowrite files when leaving
set autowriteall          " Autowrite files for all commands
set report=0              " Always tell me how many lines were affected
set dictionary=/usr/share/dict/words
set completeopt=menuone   " Show menu even for one item and no preview
set autoread              " Autoreload buffers that have changed on disk
set cmdheight=2           " Allow a bit more room for messages
set signcolumn=number     " Merge the sign column and the line number column

" }}}
" Cursor settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler                            " Show the line and column of the cursor position
set cursorline                       " Highlight the line under the cursor
set nocursorcolumn                   " Don't Highlight the column
au WinEnter * setlocal cursorline    " Turn on cursorline on focus
au WinLeave * setlocal nocursorline  " And off on losing focus

" }}}
" Color column settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show 80 char column in light grey
set colorcolumn=80
highlight ColorColumn ctermbg=239 guibg=#4f4f4f

" Disable colorcolumn in the quickfix buffers
" TODO: why the hell did I set this?!
au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap

" }}}
" Backups, undo and swapfiles {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.vim/tmp/undo,~/tmp,/tmp
set backupdir=~/.vim/tmp/backup,~/tmp,/tmp
set directory=~/.vim/tmp/swap/,~/tmp,/tmp
set updatecount=50 " save the files sooner than the default (after 50 chars)
" triggers the CursorHold event sooner than the default 4s (makes coc feel more responsive)
set updatetime=300 

" }}}
" Indentation and whitespace {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

function! <SID>StripTrailingWhitespaces()
  " Save the last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Remove trailing whitespace characters
  %s/\s\+$//e

  " Reset last search position
  let @/=_s
  " Put the cursor back where it was
  call cursor(l, c)
endfunction

"Shortcut mapping
set cindent                         " Indent new lines to same level as last
set listchars=tab:▸▸,space:·        " Nicer whitespace characters
set list                            " Show whitespace
set softtabstop=2                   " 2 spaces is a tab when editing/inserting
set tabstop=2                       " 2 spaces is equivalent to a tab
set shiftwidth=2                    " Shift by 2 spaces
set expandtab                       " Expand tab to spaces
set mouse=nv                        " Allow Mouse in normal and visual mode


" }}}
" Folding {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SimpleFoldText()
  return getline(v:foldstart).' '
endfunction

set foldlevelstart=99               " Open all folds
set foldcolumn=3                    " Show 3 levels
set foldtext=SimpleFoldText()       " Only the function name


" }}}
" Automation {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable paste mode when leaving insert mode
autocmd InsertLeave * set nopaste
" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" }}}
" Keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader=","

" Toggle NERDTRee with F2 in command mode
noremap <f2> :NERDTreeToggle<cr>
" copy and paste with xclip
vnoremap <leader>y :!xclip -f -sel  clip<CR>
" noremap <leader>p :-1r !xclip -o -sel clip<CR>

" }}}
" Tab keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>tn          :tabn<cr>
nnoremap <leader>tp          :tabp<cr>
nnoremap <leader>te          :tabe<space>
nnoremap <leader>tc          :tabclose<cr>

" }}}
" Commandline keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" }}}
" Line numbering {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber

" }}}
" Whitespace keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle whitespace
noremap <leader>l :set list!<cr>
" Strip Trailing
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<cr>
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <<

nnoremap <leader>w        :write<cr>

" }}}
" Mode switching keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exit insert mode
inoremap jk               <esc>
nnoremap <F12>            :set paste!<cr>

" }}}
" Help{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType help wincmd L      " Open help in a vertical split

" }}}
" Remap annoying default keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move up and down by screenline instead of file line
nnoremap j                gj
nnoremap k                gk
" Fix vim's regexp search to use perl regexps
nnoremap /                /\v
vnoremap \                /\v
" Don't enter ex mode
noremap Q                 <nop>

" Turn off search highlighting
nnoremap <leader><space>  :noh<cr>
" Highlight word at cursor and return to same position
nnoremap <leader>h *<C-O>

" }}}}}}
" Command Maps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable saving readonly files with sudo
cmap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" }}}
" NERDTree configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore = ['\~$','\.git']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

augroup ft_clojure
  " Disable delimitMate for clojure
  au FileType clojure let b:loaded_delimitMate=1
augroup END

" }}}
"  quickfix window and location window mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F4> :cw<CR>
nmap <silent> <LEFT>  :cprev<CR>
nmap <silent> <RIGHT> :cnext<CR>

noremap <F3> :lw<CR>

" }}}
" Status line {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " Taller status line to reduce annoying prompts
augroup ft_statusline_background_colour
  au InsertEnter * hi StatusLine ctermfg=214 guifg=#FFAF00
  au InsertLeave * hi StatusLine ctermfg=236 guifg=#CD5907
augroup END

let g:go_rename_command = 'gopls'

" }}}
" Commands to run on startup {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd VimEnter * wincmd p

  " Custom tab settings
  " make must be tabs
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd BufEnter * let &titlestring="vim: " . expand("%:t")
endif

" }}}
" Enable project level vimrcs {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set exrc
set secure
