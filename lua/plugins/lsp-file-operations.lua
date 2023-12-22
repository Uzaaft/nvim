return {
  -- "antosha417/nvim-lsp-file-operations",
  "mehalter/nvim-lsp-file-operations",
  branch = "workspace_file_operations",
  lazy = true,
  init = function(plugin) require("astrocore").on_load("neo-tree.nvim", plugin.name) end,
  main = "lsp-file-operations",
  opts = {},
}
