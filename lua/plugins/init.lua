return {
  -- disable core plugins
  { "goolord/alpha-nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  -- Very small specs not worth their own files
  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  { "mfussenegger/nvim-dap", dependencies = { { "theHamsta/nvim-dap-virtual-text", config = true } } },
  { "rcarriga/nvim-notify", opts = { timeout = 0 } },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
  { "williamboman/mason.nvim", opts = { PATH = "append" } },
}
