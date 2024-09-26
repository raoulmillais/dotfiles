local c = require('core')

--[[
-- TELESCOPE
-- ]]
c.nmap("<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
c.nmap("<C-t>", ":Telescope<CR>", { desc = "Open telescope" })
c.nmap("<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
c.nmap("<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir )" })
c.nmap("<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files )" })
c.nmap("<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" })
c.nmap("<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Commits" })
c.nmap("<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" })
c.nmap("<leader>sr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
c.nmap("<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
c.nmap("<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
c.nmap("<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
c.nmap("<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
c.nmap("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
c.nmap("<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
c.nmap("<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
c.nmap("<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
c.nmap("<leader>sj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
c.nmap("<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
c.nmap("<leader>sl", "<cmd>Telescope loclist<cr>", { desc = "Location List" })
c.nmap("<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
c.nmap("<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
c.nmap("<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
c.nmap("<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
c.nmap("<leader>sq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })
          --
-- Clobber S with fast global search and replace
c.nmap("S", ":%s::g<LEFT><LEFT>", { desc = "Global search and replace" })
-- Turn off search highlighting
c.nmap("<leader><space>", ":noh<cr>", { desc = "Disable search highlighting" })
-- Highlight word at cursor and return to same position
c.nmap("<leader>h", "*<C-O>", { desc = "Highlight other instances of word at cursor"})

--[[
--VIMUX
--]]
c.nmap("<Leader>vp", ":VimuxPromptCommand<CR>", { desc = "Vimux prompt" })
c.nmap("<Leader>vl", ":VimuxRunLastCommand<CR>", { desc = "Vimux run last command" })
-- enter vimux pane in copymode (same as entering and typing <C-[>)
c.nmap("<Leader>vi", ":VimuxInspectRunner<CR>", { desc = "Vimux inspect runner" })
c.nmap("<Leader>vc", ":VimuxCloseRunner<CR>", { desc = "Vimux close runner" })
c.nmap("<Leader>vz", ":VimuxZoomRunner<CR>", { desc = "Vimux zoom runner" })

c.nmap("<Leader>sv", ":source $MYVIMRC<CR>", { desc = "Reload neovim config" })

--[[
--NEOTREE
--]]
c.nmap("<f2>", ":Neotree toggle<cr>")

--[[
--VIM TABS
--]]
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
