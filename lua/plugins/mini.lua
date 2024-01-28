---@type LazySpec
return {
  {
    "echasnovski/mini.move",
    keys = {
      { "ﬁ", mode = { "n", "v" } },
      { "ª", mode = { "n", "v" } },
      { "√", mode = { "n", "v" } },
      { "˛", mode = { "n", "v" } },
    },
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "˛",
        right = "ﬁ",
        down = "√",
        up = "ª",

        -- Move current line in Normal mode
        line_left = "˛",
        line_right = "ﬁ",
        line_down = "√",
        line_up = "ª",
      },
      keys = {
        { "ﬁ", mode = { "n", "v" } },
        { "ª", mode = { "n", "v" } },
        { "√", mode = { "n", "v" } },
        { "˛", mode = { "n", "v" } },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    keys = {
      { "sa", desc = "Add surrounding", mode = { "n", "v" } },
      { "sd", desc = "Delete surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
      { "sh", desc = "Highlight surrounding" },
      { "sr", desc = "Replace surrounding" },
      { "sn", desc = "Update `MiniSurround.config.n_lines`" },
    },
    opts = { n_lines = 200 },
  },
  {
    "echasnovski/mini.map",
    version = "*",
    keys = {
      { "<leader>um", function() require("mini.map").toggle() end, desc = "Toggle minimap" },
    },
    opts = function()
      local map = require "mini.map"
      return {
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic {
            error = "DiagnosticFloatingError",
            warn = "DiagnosticFloatingWarn",
            info = "DiagnosticFloatingInfo",
            hint = "DiagnosticFloatingHint",
          },
        },
        symbols = {
          encode = map.gen_encode_symbols.dot "6x6",
        },
        window = {
          side = "right",
          width = 11,
          winblend = 0,
          show_integration_count = true,
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { mini = true } },
  },
}
