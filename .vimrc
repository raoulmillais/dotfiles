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

" check whether vim-plug is installed and install it if necessary
" this must happen in the vimrc for path resolution to work
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

source $HOME/.vim/init/plug.vim
source $HOME/.vim/init/general.vim
source $HOME/.vim/init/keymappings.vim
source $HOME/.vim/init/plugins.vim

"
"  Miscellaneous crap that needs tidying up!
"

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

" }}}
" Automation {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable paste mode when leaving insert mode
autocmd InsertLeave * set nopaste
" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" }}}
" Help{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType help wincmd L      " Open help in a vertical split

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

