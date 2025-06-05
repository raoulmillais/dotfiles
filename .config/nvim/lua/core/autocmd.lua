local M = {}

M.clear = vim.api.nvim_clear_autocmds

M.create = vim.api.nvim_create_autocmd

M.exec = vim.api.nvim_exec_autocmds

M.get = vim.api.nvim_get_autocmds

return M
