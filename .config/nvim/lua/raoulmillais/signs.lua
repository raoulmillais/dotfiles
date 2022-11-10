local ok, signs = pcall(require, "gitsigns")
if not ok then
  return
end

signs.setup {
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  preview_config = {
    -- Options passed to nvim_open_win
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}
