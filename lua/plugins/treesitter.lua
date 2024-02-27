---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "andymass/vim-matchup",
    dependencies = { "AstroNvim/astrocore", opts = { options = { g = { matchup_matchparen_deferred = 1 } } } },
  },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    auto_install = vim.fn.executable "tree-sitter" == 1,
    matchup = { enable = true },
  },
}
