return {
  -- "antosha417/nvim-lsp-file-operations",
  "mehalter/nvim-lsp-file-operations",
  lazy = true,
  init = function(plugin) require("astrocore").on_load("neo-tree.nvim", plugin.name) end,
  main = "lsp-file-operations",
  opts = {},
}
