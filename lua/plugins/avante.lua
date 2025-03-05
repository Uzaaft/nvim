local prefix = "<Leader>A"
return {
  "yetone/avante.nvim",
  build = "make",
  event = "User AstroFile",
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteEdit",
    "AvanteRefresh",
    "AvanteSwitchProvider",
    "AvanteChat",
    "AvanteToggle",
    "AvanteClear",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "AstroNvim/astrocore", opts = function(_, opts) opts.mappings.n[prefix] = { desc = " Avante" } end },
  },
  opts = {
    provider = "copilot_claude",
    auto_suggestions_provider = "copilot_claude",
    vendors = {
      copilot_claude = {
        __inherited_from = "copilot",
        api_key_name = "GITHUB_TOKEN",
        model = "claude-3.5-sonnet",
      },
    },
    hints = { enabled = false },
    mappings = {
      ask = prefix .. "<CR>",
      edit = prefix .. "e",
      refresh = prefix .. "r",
      focus = prefix .. "f",
      toggle = {
        default = prefix .. "t",
        debug = prefix .. "d",
        hint = prefix .. "h",
        suggestion = prefix .. "s",
        repomap = prefix .. "R",
      },
      diff = {
        next = "]c",
        prev = "[c",
      },
      files = {
        add_current = prefix .. ".",
      },
    },
    windows = {
      width = 45,
    },
  },
  specs = {
    {
      "Saghen/blink.compat",
      optional = true,
      specs = {
        {
          "Saghen/blink.cmp",
          optional = true,
          opts_extend = { "sources.default" },
          dependencies = { "yetone/avante.nvim" },
          opts = {
            sources = {
              default = { "avante_commands", "avante_mentions", "avante_files" },
              providers = {
                avante_commands = {
                  name = "avante_commands",
                  module = "blink.compat.source",
                  score_offset = 90, -- show at a higher priority than lsp
                  opts = {},
                },
                avante_files = {
                  name = "avante_commands",
                  module = "blink.compat.source",
                  score_offset = 100, -- show at a higher priority than lsp
                  opts = {},
                },
                avante_mentions = {
                  name = "avante_mentions",
                  module = "blink.compat.source",
                  score_offset = 1000, -- show at a higher priority than lsp
                  opts = {},
                },
              },
            },
          },
        },
      },
    },
    { "zbirenbaum/copilot.lua", cmd = "Copilot", opts = { panel = { enabled = false }, suggestion = { false } } },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.file_types = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "Avante" })
      end,
    },
  },
}
