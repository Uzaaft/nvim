local disabled = {
  "jay-babu/mason-null-ls.nvim",
  "nvimtools/none-ls.nvim",
}

return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, disabled)
