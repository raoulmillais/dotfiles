" Bootstrap plugins and filetypes {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible            " Turn off vi compatibility mode
filetype off                " Interferes with Vundle plugin loading

let g:python_host_prog = '/usr/bin/python3'

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'benmills/vimux'
Plugin 'benmills/vimux-golang'
Plugin 'bling/vim-bufferline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'honza/vim-snippets'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'junegunn/fzf.vim'
Plugin 'mattn/vim-lsp-settings'
Plugin 'mileszs/ack.vim.git'
Plugin 'morhetz/gruvbox'
Plugin 'othree/yajs.vim'
Plugin 'pedrohdz/vim-yaml-folds'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'ryanolsonx/vim-lsp-javascript'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'vim-scripts/jsbeautify.git'
Plugin 'vim-scripts/paredit.vim.git'
Plugin 'vim-scripts/scratch.vim'
Plugin 'vim-scripts/taglist.vim.git'
Plugin 'yami-beta/asyncomplete-omni.vim'
Plugin 'w0rp/ale'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'vifm/vifm.vim'

call vundle#end()
filetype on                 " Reenable filetype
filetype indent on
filetype plugin on

" }}}
" Colorscheme {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                                " Enable syntax highlighting
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"   " Fix colors for tmux
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"   " https://github.com/tmux/tmux/issues/1246
set termguicolors                        " Turn on 24bit colors
set background=dark                      " Dark colorscheme please
let g:gruvbox_italic=1                   " KiTTY supports italics just fine
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox


" }}}
" Diffing {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set diffopt=vertical
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	\ | wincmd p | diffthis


" }}}
" ALE linting and fixing {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_fixers = {
\  'javascript': [
\    'standard'
\  ]
\}

" }}}
" LSP {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_log_file = expand('~/vim-lsp-log.txt')

let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_error = { 'text': '✗' }
let g:lsp_signs_warning = { 'text': '⚠️' }
if executable('terraform-ls')
      au User lsp_setup call lsp#register_server({
              \ 'name': 'terraform-ls',
              \ 'cmd': {server_info->['terraform-ls', 'serve']},
              \ 'whitelist': ['terraform'],
              \ })
    endif

" }}}
" Autocomplete {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
\ 'name': 'omni',
\ 'whitelist': ['*'],
\ 'blacklist': ['c', 'cpp', 'html'],
\ 'completor': function('asyncomplete#sources#omni#completor')
\  }))
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" }}}
" Make targets {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :make build<BAR>copen<CR>
nnoremap <F6> :make test<BAR>copen<CR>



" }}}
" Markdown preview {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1

" }}}
" Vimux mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
" enter vimux pane in copymode (same as entering and typing <C-[>)
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vc :VimuxCloseRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" }}}
" Golang mappings {{{
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
" fzf mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-p> :Files<CR>
"
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
set ruler                 " Show the ruler
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
set shortmess=atI         " Shorten the large interruptive prompts
set ttyfast               " Smoother redrawing with multiple windows
set lazyredraw            " Suspend redrawing while running macros
set matchtime=3           " Jump to matching paren for a briefer time
set splitbelow            " Open new splits below current window
set splitright            " Open new vsplits to the right
set autowrite             " Autowrite files when leaving
set report=0              " Always tell me how many lines were affected
set dictionary=/usr/share/dict/words
set completeopt=menuone   " Show menu even for one item and no preview
set autoread              " Autoreload buffers that have changed on disk
set cmdheight=2           " Allow a bit more room for messages

" }}}
" Cursor settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline                       " Highlight the line under the cursor
set nocursorcolumn                   " Don't Highlight the column
au WinEnter * setlocal cursorline    " Turn on cursorline on focus
au WinLeave * setlocal nocursorline  " And off on losing focus

" }}}
" Color column settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set colorcolumn=80        " Show 80 char column in light grey
highlight ColorColumn ctermbg=239 guibg=#4f4f4f
" Disable colorcolumn in the quickfix buffers
au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap

" }}}
" Backups, undo and swapfiles {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.vim/tmp/undo,~/tmp,/tmp
set backupdir=~/.vim/tmp/backup,~/tmp,/tmp
set directory=~/.vim/tmp/swap/,~/tmp,/tmp
set noswapfile

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
noremap <leader><tab> :Stab<cr>
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
" Vimrc helpers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open .vimrc in a new split for quick editing
nnoremap <leader>ev :vs $MYVIMRC<cr>
" Auto source .vimrc when it's saved
augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END

" }}}
" Keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader=","

" Toggle NERDTRee with F2 in command mode
noremap <f2> :NERDTreeToggle<cr>
" Go to start of line
nnoremap H 0
" Go to end of line
nnoremap L $
" copy and paste with xclip
vnoremap <leader>y :!xclip -f -sel  clip<CR>
" noremap <leader>p :-1r !xclip -o -sel clip<CR>
" Disable paste mode when leaving insert mode
if has('autocommand')
  au InsertLeave * set nopaste
endif

" Fixup common save / exit typos
cnoremap W w
cnoremap Wq wq
cnoremap Wqa wqa


" }}}
" Tab keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>tn          :tabn<cr>
nnoremap <leader>tp          :tabp<cr>
nnoremap <leader>te          :tabe<space>
nnoremap <leader>tc          :tabclose<cr>

"
" }}}
" Commandline  keymaps {{{
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
" Spellchecking keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>ss             :setlocal spell!<cr>
" Next misspelling
noremap <leader>sn             ]s
" Previous misspelling
noremap <leader>sp             [s
" Add word to dictionary
noremap <leader>sa             zg
noremap <leader>s?             z=

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
" Move to matching bracket
nnoremap <tab>            %
vnoremap <tab>            %
" Don't enter ex mode
noremap Q                 <nop>

" Turn off search highlighting
nnoremap <leader><space>  :noh<cr>
" Highlight word at cursor and return to same position
nnoremap <leader>h *<C-O>

" }}}}}}
" Ack configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bring up ack ready to searc
nnoremap <leader>a        :Ack!<Space>
" Highlight word at cursor and then Ack it.
nnoremap <leader>H        *<C-O>:AckFromSearch!<CR>

" }}}}}}
" Command Maps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable saving readonly files with sudo
cmap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
cmap Q q

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

if has('autocommand')
  augroup ft_clojure
    au!

    " Disable delimitMate for clojure
    au FileType clojure let b:loaded_delimitMate=1
  augroup END
endif



" }}}
" Taglist configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
noremap <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

" }}}
" Ack configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ackprg = 'ag --nogroup --nocolor --column'

" }}}
" Cscope configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " Add cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endif

" }}}
" CtrlP configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_open_new_file = 1         " Open new files in tabs

" }}}
" Enable toggling of the quickfix and errors window {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleErrors()
  if exists("w:is_error_window")
    unlet w:is_error_window
    lclose
  else
    exec "Errors"
    botright lopen
    let w:is_error_window = 1
  endif
endfunction

function! ToggleQuickFix(forced)
  if exists('g:quickfix_is_open') && a:forced == 0
    unlet g:quickfix_is_open
    cclose
  else
    botright copen 10
    let g:quickfix_is_open = bufnr("$")
  endif
endfunction

command! -bang -nargs=? ToggleQuickFix call ToggleQuickFix(<bang>0)
command! ToggleErrors call ToggleErrors()

noremap <F4> :ToggleQuickFix<CR>
noremap <F3> :ToggleErrors<CR>

" }}}
" Scratch {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleScratch()
  if exists('w:scratch_is_open')
    unlet w:scratch_is_open
    exec "q"
  else
    Sscratch
    let w:scratch_is_open = 1
  endif
endfunction

nnoremap <leader>S call ToggleScratch()

" Always show status line
set laststatus=2

if has("autocmd")
  augroup ft_statusline_background_colour
    au InsertEnter * hi StatusLine ctermfg=15 guifg=#FF3145
    au InsertLeave * hi StatusLine ctermfg=236 guifg=#CD5907
  augroup END
endif

" }}}
" Css and less files {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less

    " Make folding work
    au FileType less,css setlocal foldmethod=marker
    au FileType less,css setlocal foldmarker={,}
  augroup END
endif

" }}}
" Javascript files {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup ft_javascript
    au!

    au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript setl formatprg=js-beautify\ -t\ -j\ -w\ 80\ -f\ -
    au BufWritePre *.js :%s/\s\+$//e
  augroup END
endif

" }}}
" JSON {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_json_syntax_conceal = 0
if has("autocmd")
  augroup ft_javascript
    au!
    au FileType json setlocal foldmethod=marker
    au FileType json setlocal foldmarker={,}


    au FileType json setlocal ts=2 sts=2 sw=2 expandtab
  augroup END
endif

" }}}
" Vimscript files {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
  augroup END
endif

" }}}
" Ruby files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_rename_command = 'gopls'

" }}}
" Ruby files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup ft_ruby
    au FileType ruby setlocal foldmethod=syntax
    au FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
    au FileType ruby map <buffer> <localleader>ra        :RunSpecs<cr>
    au FileType ruby map <buffer> <localleader>rs        :RunSpec<cr>
    au FileType ruby map <buffer> <localleader>rl        :RunSpecLine<cr>
  augroup END
endif

" }}}
" JavaScript files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup ft_javascript
    au FileType javascript setlocal foldmethod=syntax
    au FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
  augroup END
endif

" }}}
" Scheme files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup ft_scheme
    au FileType scheme setlocal foldmethod=syntax
    au FileType scheme setlocal ts=2 sts=2 sw=2 expandtab
    au FileType scheme let b:delimitMate_quotes = "\""
    au FileType scheme setlocal equalprg=scmindent.rkt
  augroup END
  autocmd filetype lisp,scheme,art setlocal equalprg=scmindent.rkt
endif

" }}}
" Scheme files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.tag :set filetype=html

" }}}
" Clojure files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunMidje() "{{{
  Eval (require 'midje.repl)(midje.repl/load-facts :all)
endfunction " }}}

command! Midje call RunMidje()

" }}}
" Commands to run on startup {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd VimEnter * wincmd p

  " Custom tab settings
  " make must be tabs
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  " yaml and coffeescript must be spaces
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
  autocmd BufEnter * let &titlestring="vim: " . expand("%:t")
endif

" }}}
" Enable project level vimrcs {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set exrc
set secure
