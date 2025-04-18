---@type LazySpec
return {
  "OXY2DEV/helpview.nvim",
  ft = "help",
  opts = {
    preview = {
      icon_provider = "mini",
    },
  },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vimdoc" })
        end
      end,
    },
  },
}
