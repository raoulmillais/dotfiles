vim9script noclear
# COC {{
###############################################################################
# Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

def CheckBackSpace(): bool
  var col = col('.') - 1
  return col == 0 || getline('.')[col - 1]  =~# '\s'
enddef

# Easier to type :Prettier command that uses coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
# Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

nnoremap <leader>cr <Plug>(coc-rename)
nnoremap <leader>cd <Plug>(coc-definition)
nnoremap <leader>cy <Plug>(coc-type-definition)
nnoremap <leader>cR <Plug>(coc-references)
nnoremap <leader>ca :CocAction<cr>
nnoremap <leader>cD :CocDiagnostics<cr>

# Format document
vnoremap <leader>cf  <Plug>(coc-format-selected)
nnoremap <leader>cf  <Plug>(coc-format-selected)

# Use `[g` and `]g` to navigate diagnostics
# Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
# This matches the vim-unimpaired key bindings
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
# }}}

# SEARCH {{{
###############################################################################
# Clobber S with fast global search and replace
nnoremap S :%s::g<LEFT><LEFT>
# Clobber M with mapping to replace all last search
nnoremap <expr> M  ':%s/' . @/ . '//g<LEFT><LEFT>' "
# Turn off search highlighting
nnoremap <leader><space>  :noh<cr>
# Highlight word at cursor and return to same position
nnoremap <leader>h *<C-O>
# Fix vim's regexp search to use perl regexps
nnoremap /                /\v
vnoremap \                /\v
# }}}

# VIMUX {{{
###############################################################################
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
# enter vimux pane in copymode (same as entering and typing <C-[>)
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vc :VimuxCloseRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>
# }}}

# GOLANG {{{
###############################################################################
nnoremap <Leader>gb  :GoBuild<CR>
nnoremap <Leader>gd  :GoDoc<CR>
nnoremap <Leader>gi  :GoInfo<CR>
nnoremap <Leader>grn :GoRename<CR>
nnoremap <Leader>gre :GoReferrers<CR>
nnoremap <Leader>gtd :GoDef<CR>
nnoremap <Leader>gta :GolangTestCurrentPackage<CR>
nnoremap <Leader>gtf :GolangTestFocused<CR>
nnoremap <Leader>gcc :GoCoverageToggle!<CR>
# }}}

# NERDTREE {{{
###############################################################################
noremap <f2> :NERDTreeToggle<cr>
# }}}

# VIM TABS {{{
###############################################################################
nnoremap <leader>tn          :tabn<cr>
nnoremap <leader>tp          :tabp<cr>
nnoremap <leader>te          :tabe<space>
nnoremap <leader>tc          :tabclose<cr>
# }}}

# COMMANDLINE {{{
###############################################################################
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
# }}}

# WHITESPACE {{{
###############################################################################
# Toggle whitespace
noremap <leader>l :set list!<cr>
# Strip Trailing
nnoremap <leader>W :call whitespace#Strip()<cr>
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <<
# }}}

# MODE SWITCHING {{{
###############################################################################
# Exit insert mode
inoremap jk               <esc>
nnoremap <F12>            :set paste!<cr>
# }}}

# REMAP ANNOYING DEFAULTS {{{
###############################################################################
# Move up and down by screenline instead of file line
nnoremap j                gj
nnoremap k                gk
# Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
# Revert with ":unmap Q".
noremap Q gq
sunmap Q
# }}}

# SUDO {{{
###############################################################################
# Enable saving readonly files with sudo
cnoremap w!! %!sudo tee > /dev/null %
# }}}
