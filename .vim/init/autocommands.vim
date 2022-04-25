" AUTOMATION {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable paste mode when leaving insert mode
autocmd InsertLeave * set nopaste
" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" }}}


" HELP {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ft_help
  autocmd! 

  autocmd FileType help wincmd L      " Open help in a vertical split
augroup END
" }}}

" STATUS LINE {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " Taller status line to reduce annoying prompts
augroup ft_statusline_background_colour
  autocmd! 

  autocmd InsertEnter * hi StatusLine ctermfg=214 guifg=#FFAF00
  autocmd InsertLeave * hi StatusLine ctermfg=236 guifg=#CD5907
augroup END
" }}}

" GENERAL {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup global_automation
  autocmd!
  " refocus last window on enter
  autocmd VimEnter * wincmd p

  " make must be tabs
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  " set the titlestring properly for tmux
  autocmd BufEnter * let &titlestring="vim: " . expand("%:t")
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END
" }}}
