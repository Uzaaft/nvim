local disabled = {
  "jay-babu/mason-null-ls.nvim",
  "nvimtools/none-ls.nvim",
  -- Custom disable stuff
  "Exafunction/codeium.vim",
  -- "HiPhish/rainbow-delimiters.nvim",
  "nvim-telescope/telescope-bibtex.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  "jay-babu/mason-nvim-dap.nvim",
  "kdheepak/cmp-latex-symbols",
  "nvim-neotest/neotest",
}

return vim.tbl_map(function(plugin) return { plugin, enabled = false } end, disabled)
