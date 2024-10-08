---@type LazySpec
return {
  "echasnovski/mini.move",
  keys = {
    { "<M-l>", mode = { "n", "v" } },
    { "<M-k>", mode = { "n", "v" } },
    { "<M-j>", mode = { "n", "v" } },
    { "<M-h>", mode = { "n", "v" } },
  },
  opts = {},
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { mini = true } },
    },
  },
}
