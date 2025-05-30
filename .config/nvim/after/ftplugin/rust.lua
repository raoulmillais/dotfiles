local c = require('core')

vim.opt_local.makeprg = "cargo run"
c.nmap("<F5>", ":make<cr>")

