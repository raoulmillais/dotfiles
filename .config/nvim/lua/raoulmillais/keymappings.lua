local keymap = vim.keymap

-- TELESCOPE {{{
nmap("<C-p>", ":Telescope find_files<CR>")
-- }}}
--
-- SEARCH {{{1
-- Clobber S with fast global search and replace
nmap("S", ":%s::g<LEFT><LEFT>")
-- Turn off search highlighting
nmap("<leader><space>", ":noh<cr>")
-- Highlight word at cursor and return to same position
nmap("<leader>h", "*<C-O>")
-- }}}

-- VIMUX {{{1
nmap("<Leader>vp", ":VimuxPromptCommand<CR>")
nmap("<Leader>vl", ":VimuxRunLastCommand<CR>")
-- enter vimux pane in copymode (same as entering and typing <C-[>)
nmap("<Leader>vi", ":VimuxInspectRunner<CR>")
nmap("<Leader>vc", ":VimuxCloseRunner<CR>")
nmap("<Leader>vz", ":VimuxZoomRunner<CR>")
-- }}}

-- GOLANG {{{1
-- TODO: Use Lsp builtins instead
nmap("<Leader>gb", ":GoBuild<CR>")
nmap("<Leader>gd", ":GoDoc<CR>")
nmap("<Leader>gi", ":GoInfo<CR>")
nmap("<Leader>grn", ":GoRename<CR>")
nmap("<Leader>gre", ":GoReferrers<CR>")
nmap("<Leader>gtd", ":GoDef<CR>")
nmap("<Leader>gta", ":GolangTestCurrentPackage<CR>")
nmap("<Leader>gtf", ":GolangTestFocused<CR>")
nmap("<Leader>gcc", ":GoCoverageToggle!<CR>")
-- }}}

-- NVIMTREE {{{1
nmap("<f2>", ":NvimTreeToggle<cr>")
-- }}}

-- VIM TABS {{{1
nmap("<leader>tn", ":tabn<cr>")
nmap("<leader>tp", ":tabp<cr>")
nmap("<leader>te", ":tabe<space>")
nmap("<leader>tc", ":tabclose<cr>")
-- }}}

-- COMMANDLINE {{{1
cmap("<C-j>", "t_kd>")
cmap("<C-k>", "t_ku>")
cmap("<C-a>", "Home>")
cmap("<C-e>", "End>")
-- }}}

-- WHITESPACE {{{1
-- Toggle whitespace
nmap("<leader>l", "set list!<cr>")
-- }}}

-- MODE SWITCHING {{{1
-- Exit insert mode
imap("jk", "<esc>")
nmap("<F12>", ":set paste!<cr>")
-- }}}

-- REMAP ANNOYING DEFAULTS {{{1
-- Move up and down by screenline instead of file line
nmap("j", "gj")
nmap("k", "gk")
-- Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
-- Revert with ":unmap Q".
keymap.set("", "Q", "gq")
keymap.del("s", "Q")
-- }}}

-- SUDO {{{1
-- Enable saving readonly files with sudo
cmap("w!!", "%!sudo tee > /dev/null %")
