return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = { input = {} },
  specs = {
    { "stevearc/dressing.nvim", enabled = false },
  },
}
