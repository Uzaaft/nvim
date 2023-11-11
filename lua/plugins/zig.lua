local utils = require "astrocore"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "zig" })
      end
    end,
  },
  {
    "NTBBloodbath/zig-tools.nvim",
    -- Load zig-tools.nvim only in Zig buffers
    ft = { "zig" },
    opts = {},
    dependencies = {
      {
        "akinsho/toggleterm.nvim",
      },
      {
        "nvim-lua/plenary.nvim",
      },
    },
  },
}
