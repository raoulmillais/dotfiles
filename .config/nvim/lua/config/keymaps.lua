local c = require('core')

c.nmap("S", ":%s::g<LEFT><LEFT>", { desc = "Global search and replace" })
c.nmap("<leader><space>", ":noh<cr>", { desc = "Disable search highlighting" })
c.nmap("<leader>h", "*<C-O>", { desc = "Highlight other instances of word at cursor"})
c.nmap("<Leader>sv", ":source $MYVIMRC<CR>", { desc = "Reload neovim config" })

-- tabs
c.nmap("<leader>tn", ":tabn<cr>", { desc = "Next tab" })
c.nmap("<leader>tp", ":tabp<cr>", { desc = "Previous tab" })
c.nmap("<leader>te", ":tabe<space>", { desc = "New empty tab" })
c.nmap("<leader>tc", ":tabclose<cr>", { desc = "Close tab" })

-- Command line remappings like standard (non-vi mode) readline mappings
c.cmap("<C-j>", "t_kd>")
c.cmap("<C-k>", "t_ku>")
c.cmap("<C-a>", "Home>")
c.cmap("<C-e>", "End>")

-- Exit insert mode
c.imap("jk", "<esc>")
-- Always disable `paste` when leaving insert mode
c.nmap("<F12>", ":set paste!<cr>")

-- Move up and down by screenline instead of file line
c.nmap("j", "gj")
c.nmap("k", "gk")

-- Enable saving readonly files with sudo
c.cmap("w!!", "%!sudo tee > /dev/null %")

--[[
-- These keymaps will be installed at the relevant time by their respective
-- plugins.  They are defined here to more easily view all keymaps at a glance.
--
-- Any keymaps defined here will be installed with `noremap`
-- ]]
local keymaps = {
  diagnostics = {
    { "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostics in float"}},
    { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Goto previous diagnostic" } },
    { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Goto next diagnostic"} },
    { "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Open diagnostics in location list" } },
  },
  lsp = {
    -- lsp keymaps are set per buffer when an LSP client attaches unlike other
    -- plugins which usually attach keymaps globally when they initialise
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" } },
    { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" } },
    { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "LSP Hover" } },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" } },
    { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Show signature" } },
    { "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { desc = "Add workspace folder" } },
    { "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { desc = "Remove workspace folder" } },
    { "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { desc = "List workspace folders" } },
    { "<leader>cy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type definition" } },
    { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename file" } },
    { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code acion" } },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find references" } },
    { "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", { desc = "Format buffer" } },
  },
  telescope = {
    { "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" } },
    { "<C-t>", ":Telescope<CR>", { desc = "Open telescope" } },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" } },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir )" } },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files )" } },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" } },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Commits" } },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" } },
    { "<leader>sr", "<cmd>Telescope registers<cr>", { desc = "Registers" } },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" } },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" } },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" } },
    { "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" } },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" } },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" } },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" } },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" } },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" } },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" } },
    { "<leader>sl", "<cmd>Telescope loclist<cr>", { desc = "Location List" } },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" } },
    { "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" } },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" } },
    { "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" } },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" } },
  },
  neotree = {
    { "<f2>", ":Neotree toggle<cr>", { desc = "Toggle Neotree" } },
  },
}

return keymaps
