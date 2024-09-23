return {
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim',
    opts = {
      -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame = true, 
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      }
    }
  }
}
