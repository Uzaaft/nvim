return {
  -- "antosha417/nvim-lsp-file-operations",
  "mehalter/nvim-lsp-file-operations",
  lazy = true,
  init = function()
    require("astrocore").on_load(
      "neo-tree.nvim",
      function() require("lazy").load { plugins = { "nvim-lsp-file-operations" } } end
    )
  end,
  main = "lsp-file-operations",
  opts = {},
}
