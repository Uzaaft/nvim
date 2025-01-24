return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = function(_, opts)
    opts.notifier = { timeout = 1000 }
    local get_icon = require("astroui").get_icon
    opts.notifier.icons = {
      DEBUG = get_icon "Debugger",
      ERROR = get_icon "DiagnosticError",
      INFO = get_icon "DiagnosticInfo",
      TRACE = get_icon "DiagnosticHint",
      WARN = get_icon "DiagnosticWarn",
    }
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>uD"] = { function() require("snacks.notifier").hide() end, desc = "Dismiss notifications" },
            ["<Leader>fn"] = { function() require("snacks.notifier").show_history() end, desc = "Find notifications" },
          },
        },
      },
    },
    { "rcarriga/nvim-notify", enabled = false },
  },
}
