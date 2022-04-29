vim9script noclear

# GO {{{
g:go_rename_command = 'gopls'
# }}}

# ICED {{{
###############################################################################
g:iced_enable_default_key_mappings = v:true
g:iced#debug#debugger = 'fern'
g:sexp_enable_insert_mode_mappings = 0
# }}}

# FZF {{{
###############################################################################
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/bundle/fzf.vim/bin/preview.sh {}']}, <bang>0)
nnoremap <C-p> :GFiles<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
# }}}

# NOTES {{{
###############################################################################
g:notes_directories = ['~/Notes']
# }}}

# NERDTREE {{{
###############################################################################
g:NERDTreeIgnore = ['\~$', '\.git']
g:NERDTreeMinimalUI = 1
g:NERDTreeDirArrows = 1

# DEVICONS {{{
###############################################################################
# after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
# }}}
