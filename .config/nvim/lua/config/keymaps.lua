local c = require('core')

--
-- TELESCOPE {{{
c.nmap("<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
-- }}}
--
-- SEARCH {{{1
-- Clobber S with fast global search and replace
c.nmap("S", ":%s::g<LEFT><LEFT>", { desc = "Global search and replace" })
-- Turn off search highlighting
c.nmap("<leader><space>", ":noh<cr>", { desc = "Disable search highlighting" })
-- Highlight word at cursor and return to same position
c.nmap("<leader>h", "*<C-O>", { desc = "Highlight other instances of word at cursor"})
-- }}}

-- VIMUX {{{1
c.nmap("<Leader>vp", ":VimuxPromptCommand<CR>", { desc = "Vimux prompt" })
c.nmap("<Leader>vl", ":VimuxRunLastCommand<CR>", { desc = "Vimux run last command" })
-- enter vimux pane in copymode (same as entering and typing <C-[>)
c.nmap("<Leader>vi", ":VimuxInspectRunner<CR>", { desc = "Vimux inspect runner" })
c.nmap("<Leader>vc", ":VimuxCloseRunner<CR>", { desc = "Vimux close runner" })
c.nmap("<Leader>vz", ":VimuxZoomRunner<CR>", { desc = "Vimux zoom runner" })
-- }}}

c.nmap("<Leader>sv", ":source $MYVIMRC<CR>", { desc = "Reload neovim config" })

-- NEOTREE {{{1
c.nmap("<f2>", ":Neotree toggle<cr>")
-- }}}

-- VIM TABS {{{1
c.nmap("<leader>tn", ":tabn<cr>")
c.nmap("<leader>tp", ":tabp<cr>")
c.nmap("<leader>te", ":tabe<space>")
c.nmap("<leader>tc", ":tabclose<cr>")
-- }}}

-- COMMANDLINE {{{1
c.cmap("<C-j>", "t_kd>")
c.cmap("<C-k>", "t_ku>")
c.cmap("<C-a>", "Home>")
c.cmap("<C-e>", "End>")
-- }}}

-- MODE SWITCHING {{{1
-- Exit insert mode
c.imap("jk", "<esc>")
c.nmap("<F12>", ":set paste!<cr>")
-- }}}

-- REMAP ANNOYING DEFAULTS {{{1
-- Move up and down by screenline instead of file line
c.nmap("j", "gj")
c.nmap("k", "gk")
-- Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
-- Revert with ":uc.nmap Q".
vim.keymap.set("", "Q", "gq")
vim.keymap.del("s", "Q")
-- }}}

-- SUDO {{{1
-- Enable saving readonly files with sudo
c.cmap("w!!", "%!sudo tee > /dev/null %")
