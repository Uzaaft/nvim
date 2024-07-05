---@type LazySpec
return {
  "echasnovski/mini.move",
  specs = {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { mini = true } },
  },
  keys = {
    { "<M-l>", mode = { "n", "v" } },
    { "<M-k>", mode = { "n", "v" } },
    { "<M-j>", mode = { "n", "v" } },
    { "<M-h>", mode = { "n", "v" } },
  },
  opts = {},
}
