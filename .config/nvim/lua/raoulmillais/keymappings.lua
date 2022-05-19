local keymap = vim.keymap

-- COC {{{1
-- Use tab for trigger completion with characters ahead and navigate.
keymap.set("i", "<Tab>", function () 
  return vm.fn.pumvisible == 1 and "<C-N>" or "<Tab>"
end, { expr = true })
keymap.set("i", "<S-Tab>", function () 
  return vm.fn.pumvisible == 1 and "<C-p>" or "<C-h>"
end, { expr = true })

-- Easier to type :Prettier command that uses coc-prettier
-- TODO: MOve this command to commands and convert to lua
-- command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
-- Use <c-space> to trigger completion.
keymap.set("i", "<c-@>", "coc#refresh()")

keymap.set("n", "<leader>cr", "<Plug>(coc-rename)")
keymap.set("n", "<leader>cd", "<Plug>(coc-definition)")
keymap.set("n", "<leader>cy", "<Plug>(coc-type-definition)")
keymap.set("n", "<leader>cR", "<Plug>(coc-references)")
keymap.set("n", "<leader>ca", ":CocAction<cr>")
keymap.set("n", "<leader>cD", ":CocDiagnostics<cr>")

-- Format document
keymap.set("v", "<leader>cf", "<Plug>(coc-format-selected)")
keymap.set("n", "<leader>cf", "<Plug>(coc-format-selected)")

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
-- This matches the vim-unimpaired key bindings
keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)")
keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)")
-- }}}

-- SEARCH {{{1
-- Clobber S with fast global search and replace
keymap.set("n", "S", ":%s::g<LEFT><LEFT>")
-- Turn off search highlighting
keymap.set("n", "<leader><space>",  ":noh<cr>")
-- Highlight word at cursor and return to same position
keymap.set("n", "<leader>h", "*<C-O>")
-- }}}

-- VIMUX {{{1
keymap.set("n", "<Leader>vp", ":VimuxPromptCommand<CR>")
keymap.set("n", "<Leader>vl", ":VimuxRunLastCommand<CR>")
-- enter vimux pane in copymode (same as entering and typing <C-[>)
keymap.set("n",  "<Leader>vi", ":VimuxInspectRunner<CR>")
keymap.set("n", "<Leader>vc", ":VimuxCloseRunner<CR>")
keymap.set("n", "<Leader>vz", ":VimuxZoomRunner<CR>")
-- }}}

-- GOLANG {{{1
-- TODO: Use Lsp builtins instead
keymap.set("n", "<Leader>gb", ":GoBuild<CR>")
keymap.set("n", "<Leader>gd", ":GoDoc<CR>")
keymap.set("n", "<Leader>gi", ":GoInfo<CR>")
keymap.set("n", "<Leader>grn", ":GoRename<CR>")
keymap.set("n", "<Leader>gre", ":GoReferrers<CR>")
keymap.set("n", "<Leader>gtd", ":GoDef<CR>")
keymap.set("n", "<Leader>gta", ":GolangTestCurrentPackage<CR>")
keymap.set("n", "<Leader>gtf", ":GolangTestFocused<CR>")
keymap.set("n", "<Leader>gcc", ":GoCoverageToggle!<CR>")
-- }}}

-- NERDTREE {{{1
keymap.set("n", "<f2>", ":NERDTreeToggle<cr>")
-- }}}

-- VIM TABS {{{1
keymap.set("n", "<leader>tn", ":tabn<cr>")
keymap.set("n", "<leader>tp", ":tabp<cr>")
keymap.set("n", "<leader>te", ":tabe<space>")
keymap.set("n", "<leader>tc", ":tabclose<cr>")
-- }}}

-- COMMANDLINE {{{1
keymap.set("c", "<C-j>", "t_kd>")
keymap.set("c", "<C-k>", "t_ku>")
keymap.set("c", "<C-a>", "Home>")
keymap.set("c", "<C-e>", "End>")
-- }}}

-- WHITESPACE {{{1
-- Toggle whitespace
keymap.set("n", "<leader>l", "set list!<cr>")
-- }}}

-- MODE SWITCHING {{{1
-- Exit insert mode
keymap.set("i", "jk", "<esc>")
keymap.set("n", "<F12>", ":set paste!<cr>")
-- }}}

-- REMAP ANNOYING DEFAULTS {{{1
-- Move up and down by screenline instead of file line
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")
-- Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
-- Revert with ":unmap Q".
keymap.set("", "Q", "gq")
keymap.del("s", "Q")
-- }}}

-- SUDO {{{1
-- Enable saving readonly files with sudo
keymap.set("c", "w!!", "%!sudo tee > /dev/null %")
