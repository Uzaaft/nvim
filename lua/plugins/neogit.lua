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
            ["<Leader>gG"] = { function() vim.cmd.Neogit() end, desc = "Neogit" },
            ["<Leader>gn"] = { function() vim.cmd.Neogit "commit" end, desc = "New Git commit" },
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
