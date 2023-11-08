return {
  -- disable core plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },

  -- Very small specs not worth their own files
  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  { "mfussenegger/nvim-dap", dependencies = { { "theHamsta/nvim-dap-virtual-text", config = true } } },
  { "rcarriga/nvim-notify", opts = { timeout = 0 } },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
}
