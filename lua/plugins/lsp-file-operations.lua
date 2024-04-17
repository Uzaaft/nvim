---@type LazySpec
return {
  "antosha417/nvim-lsp-file-operations",
  init = function(plugin) require("astrocore").on_load("neo-tree.nvim", plugin.name) end,
  main = "lsp-file-operations",
  opts = {},
}
