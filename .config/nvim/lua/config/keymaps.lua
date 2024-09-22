imap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

nmap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

cmap = function(lhs, rhs, opts)
  vim.keymap.set("c", lhs, rhs, opts)
end

--
-- TELESCOPE {{{
nmap("<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
-- }}}
--
-- SEARCH {{{1
-- Clobber S with fast global search and replace
nmap("S", ":%s::g<LEFT><LEFT>", { desc = "Global search and replace" })
-- Turn off search highlighting
nmap("<leader><space>", ":noh<cr>", { desc = "Disable search highlighting" })
-- Highlight word at cursor and return to same position
nmap("<leader>h", "*<C-O>", { desc = "Highlight other instances of word at cursor"})
-- }}}

-- VIMUX {{{1
nmap("<Leader>vp", ":VimuxPromptCommand<CR>", { desc = "Vimux prompt" })
nmap("<Leader>vl", ":VimuxRunLastCommand<CR>", { desc = "Vimux run last command" })
-- enter vimux pane in copymode (same as entering and typing <C-[>)
nmap("<Leader>vi", ":VimuxInspectRunner<CR>", { desc = "Vimux inspect runner" })
nmap("<Leader>vc", ":VimuxCloseRunner<CR>", { desc = "Vimux close runner" })
nmap("<Leader>vz", ":VimuxZoomRunner<CR>", { desc = "Vimux zoom runner" })
-- }}}

nmap("<Leader>sv", ":source $MYVIMRC<CR>", { desc = "Reload neovim config" })

-- NEOTREE {{{1
nmap("<f2>", ":Neotree toggle<cr>")
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
vim.keymap.set("", "Q", "gq")
vim.keymap.del("s", "Q")
-- }}}

-- SUDO {{{1
-- Enable saving readonly files with sudo
cmap("w!!", "%!sudo tee > /dev/null %")
