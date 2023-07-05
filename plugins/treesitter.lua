return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "andymass/vim-matchup", init = function() vim.g.matchup_matchparen_deferred = 1 end },
      "HiPhish/rainbow-delimiters.nvim",
    },
    opts = {
      auto_install = vim.fn.executable "tree-sitter" == 1,
      highlight = { disable = { "help" } },
      matchup = { enable = true },
    },
  },
}
