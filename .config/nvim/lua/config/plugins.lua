vim.g.sexp_enable_insert_mode_mappings = 0
-- }}}

-- DEVICONS {{{1
vim.g.webdevicons_enable_nerdtree = 1
-- after a re-source, fix syntax matching issues (concealing brackets):
if vim.g.loaded_webdevicons == true then
  vim.cmd [[ call webdevicons#refresh() ]]
end
-- }}}
