return {
  { "goolord/alpha-nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  {
    "lewis6991/gitsigns.nvim",
    opts = { signcolumn = false, numhl = true, current_line_blame_opts = { ignore_whitespace = true } },
  },
  { "rcarriga/nvim-notify", opts = { timeout = 0 } },
}
