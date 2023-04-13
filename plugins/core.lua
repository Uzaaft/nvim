return {
  { "goolord/alpha-nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      terminal_mappings = false,
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 0,
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    opts = {
      wrap_at_edge = false,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame_opts = { ignore_whitespace = true },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = { ".github", ".gitignore" },
        },
      },
    },
  },
}
