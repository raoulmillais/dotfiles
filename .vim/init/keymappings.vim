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

nnoremap <leader>cr <Plug>(coc-rename)
nnoremap <leader>cd <Plug>(coc-definition)
nnoremap <leader>cy <Plug>(coc-type-definition)
nnoremap <leader>cR <Plug>(coc-references)
nnoremap <leader>ca :CocAction<cr>
nnoremap <leader>cD :CocDiagnostics<cr>

" Format document
vnoremap <leader>cf  <Plug>(coc-format-selected)
nnoremap <leader>cf  <Plug>(coc-format-selected)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" This matches the vim-unimpaired key bindings
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

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
" Search mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clobber S with fast global search and replace
nnoremap S :%s::g<LEFT><LEFT>
" Clobber M with mapping to replace all last search
nnoremap <expr> M  ':%s/' . @/ . '//g<LEFT><LEFT>' "

" }}}
" Vimux {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
" enter vimux pane in copymode (same as entering and typing <C-[>)
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vc :VimuxCloseRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>

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
" Whitespace keymaps {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle whitespace
noremap <leader>l :set list!<cr>
" Strip Trailing
nnoremap <leader>W :call whitespace#Strip()<cr>
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
cnoremap w!! %!sudo tee > /dev/null %
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
