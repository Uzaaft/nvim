---@type LazySpec
return {
  "andymass/vim-matchup",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            matchup_matchparen_nomode = "i",
            matchup_matchparen_deferred = 1,
            matchup_matchparen_offscreen = {},
          },
        },
      },
    },
  },
  specs = {
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = { "andymass/vim-matchup" },
      ---@type TSConfig
      ---@diagnostic disable-next-line: missing-fields
      opts = {
        matchup = { enable = true },
      },
    },
  },
}
