---@type LazySpec
return {
  "mikesmithgh/kitty-scrollback.nvim",
  dependencies = { "AstroNvim/astrocore" },
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = "User KittyScrollbackLaunch",
  opts = {},
}
