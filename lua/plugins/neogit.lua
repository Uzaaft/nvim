---@type LazySpec
return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>gG"] = { function() require("neogit").open() end, desc = "Neogit" },
          },
        },
      },
    },
    opts = {
      disable_builtin_notifications = true,
      integrations = { telescope = true },
      signs = { section = { "", "" }, item = { "", "" } },
    },
  },
  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { neogit = true } },
  },
}
