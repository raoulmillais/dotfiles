local keymappings = {}

local opts = { noremap = true, silent = true }

local nmap_buf = function(bufnr, lhs, rhs, o)
  vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, o)
end

local function describe(desc)
  local o = {}
  for k, v in pairs(opts) do
    o[k] = v
  end
  o.desc = desc
  return o
end

keymappings.on_attach = function(_, bufnr)
  nmap_buf(bufnr, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", describe("Go to declaration"))
  nmap_buf(bufnr, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", describe("Go to definition"))
  nmap_buf(bufnr, "K", "<cmd>lua vim.lsp.buf.hover()<CR>", describe("LSP Hover"))
  nmap_buf(bufnr, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", describe("Go to implementation"))
  nmap_buf(bufnr, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", describe("Show signature"))
  nmap_buf(bufnr, "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", describe("Add workspace folder"))
  nmap_buf(bufnr, "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", describe("Remove workspace folder"))
  nmap_buf(bufnr, "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", describe("List workspace folders"))
  nmap_buf(bufnr, "<leader>cy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", describe("Type definition"))
  nmap_buf(bufnr, "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", describe("Rename file"))
  nmap_buf(bufnr, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", describe("Code acion"))
  nmap_buf(bufnr, "gr", "<cmd>lua vim.lsp.buf.references()<CR>", describe("Find references"))
  nmap_buf(bufnr, "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", describe("Format buffer"))
  nmap_buf(bufnr, "<leader>ca", ":CodeActionMenu<CR>", describe("Code action menu"))
end

return keymappings
