return {
  "knubie/vim-kitty-navigator",
  cmd = { "KittyNavigateLeft", "KittyNavigateRight", "KittyNavigateUp", "KittyNavigateDown" },
  init = function() vim.g.kitty_navigator_no_mappings = 1 end,
  build = "cp ./*.py ~/.config/kitty/",
}
