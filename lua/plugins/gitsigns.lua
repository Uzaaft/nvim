---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    signcolumn = false,
    numhl = true,
    current_line_blame_opts = { ignore_whitespace = true },
  },
}
