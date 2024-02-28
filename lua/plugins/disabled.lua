---@type LazySpec
return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, {
  "lukas-reineke/indent-blankline.nvim",
  "goolord/alpha-nvim",
  "max397574/better-escape.nvim",
  "nvimtools/none-ls.nvim",
  "jay-babu/mason-null-ls.nvim",
})
