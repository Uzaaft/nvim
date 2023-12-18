return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "andymass/vim-matchup", init = function() vim.g.matchup_matchparen_deferred = 1 end },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    auto_install = vim.fn.executable "tree-sitter" == 1,
    ensure_installed = { "bash", "markdown", "markdown_inline", "regex", "vim" },
    matchup = { enable = true },
  },
}
