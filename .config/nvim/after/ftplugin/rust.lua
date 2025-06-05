local map = require('core.map')

vim.opt_local.makeprg = "cargo run"
map.buf.n("<F5>", ":make<cr>")

