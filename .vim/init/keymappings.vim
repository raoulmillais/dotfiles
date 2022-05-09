vim9script noclear

# See :help map-which-keys

# Calling functions from mappings (see :help usr_41.txt)
#
# <SID> can be used with mappings.  It generates a script ID, which identifies
# the current script.  In our typing correction plugin we use it like this: >
# 
#  24	noremap <unique> <script> <Plug>TypecorrAdd;  <SID>Add
#  ..
#  28	noremap <SID>Add  :call <SID>Add(expand("<cword>"), true)<CR>
# 
# Thus when a user types "\a", this sequence is invoked: >
# 
# 	\a  ->  <Plug>TypecorrAdd;  ->  <SID>Add  ->  :call <SID>Add(...)
# 
# If another script also maps <SID>Add, it will get another script ID and
# thus define another mapping.
# 
# Note that instead of Add() we use <SID>Add() here.  That is because the
# mapping is typed by the user, thus outside of the script context.  The <SID>
# is translated to the script ID, so that Vim knows in which script to look for
# the Add() function.
# 
# This is a bit complicated, but it's required for the plugin to work together
# with other plugins.  The basic rule is that you use <SID>Add() in mappings and
# Add() in other places (the script itself, autocommands, user commands).

# COC {{{1
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

# SEARCH {{{1
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

# VIMUX {{{1
###############################################################################
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
# enter vimux pane in copymode (same as entering and typing <C-[>)
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vc :VimuxCloseRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>
# }}}

# GOLANG {{{1
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

# NERDTREE {{{1
###############################################################################
noremap <f2> :NERDTreeToggle<cr>
# }}}

# VIM TABS {{{1
###############################################################################
nnoremap <leader>tn          :tabn<cr>
nnoremap <leader>tp          :tabp<cr>
nnoremap <leader>te          :tabe<space>
nnoremap <leader>tc          :tabclose<cr>
# }}}

# COMMANDLINE {{{1
###############################################################################
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
# }}}

# WHITESPACE {{{1
###############################################################################
# Toggle whitespace
noremap <leader>l :set list!<cr>
# Strip Trailing
nnoremap <leader>W :call whitespace#Strip()<cr>
nnoremap <S-Tab>          <<
vnoremap <S-Tab>          <<
# }}}

# MODE SWITCHING {{{1
###############################################################################
# Exit insert mode
inoremap jk               <esc>
nnoremap <F12>            :set paste!<cr>
# }}}

# REMAP ANNOYING DEFAULTS {{{1
###############################################################################
# Move up and down by screenline instead of file line
nnoremap j                gj
nnoremap k                gk
# Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
# Revert with ":unmap Q".
noremap Q gq
sunmap Q
# }}}

# SUDO {{{1
###############################################################################
# Enable saving readonly files with sudo
cnoremap w!! %!sudo tee > /dev/null %
# }}}
