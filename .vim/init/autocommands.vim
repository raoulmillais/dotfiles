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

" }}}
" Commands to run on startup {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd VimEnter * wincmd p

  " make must be tabs
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd BufEnter * let &titlestring="vim: " . expand("%:t")
endif


