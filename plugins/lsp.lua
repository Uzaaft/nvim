return {
  "nanotee/sqls.nvim",
  {
    "jose-elias-alvarez/typescript.nvim",
    opts = function() return { server = require("astronvim.utils.lsp").config "tsserver" } end,
  },
  {
    "p00f/clangd_extensions.nvim",
    opts = function() return { server = require("astronvim.utils.lsp").config "clangd" } end,
  },
  { "neovim/nvim-lspconfig", dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
  } },
}
