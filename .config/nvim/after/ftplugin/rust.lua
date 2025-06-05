local map = require('core.nvim.map')

vim.opt_local.makeprg = "cargo run"
map.buf.n("<F5>", ":make<cr>")

