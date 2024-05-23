local dapui = require("dapui")

dapui.setup {
 icons = { expanded = "", collapsed = "" },
 mappings = {
   expanded = { "<CR>", "<2-LeftMouse>" },
   open = "o",
   remove = "d",
   edit = "e",
   repl = "r",
   toggle = "t",
 },
 expand_lines = vim.fn.has("nvim-0.7"),
 sidebar = {
   elements = {
     { id = "scopes", size = 0.25, },
     { id = "breakpoints", size = 0.25, },
     { id = "stacks", size = 0.25, },
   },
   size = 40,
   position = "left",
  },
  tray = {
    elements = { "repl", "console" },
    size = 10,
    position = "bottom",
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<ESC>" },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil,
    }
  }
}
