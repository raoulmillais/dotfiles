local keymappings = {}

local opts = { noremap = true, silent = true }

keymappings.on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  set_buf(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  nmap_buf(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  nmap_buf(bufnr, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  nmap_buf(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  nmap_buf(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  nmap_buf(bufnr, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  nmap_buf(bufnr, "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  nmap_buf(bufnr, "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  nmap_buf(bufnr, "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  nmap_buf(bufnr, "<leader>cy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  nmap_buf(bufnr, "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  nmap_buf(bufnr, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  nmap_buf(bufnr, "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  nmap_buf(bufnr, "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  nmap_buf(bufnr, "<leader>ca", ":CodeActionMenu<CR>", opts)
end

return keymappings
