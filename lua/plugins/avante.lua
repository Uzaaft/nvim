local prefix = "<Leader>A"
return {
  "yetone/avante.nvim",
  enabled = false, -- test out CodeCompanion
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
    provider = "glados",
    auto_suggestions_provider = "glados",
    vendors = {
      copilot_claude = {
        __inherited_from = "copilot",
        api_key_name = "GITHUB_TOKEN",
        model = "claude-3.5-sonnet",
      },
      glados = {
        __inherited_from = "openai",
        endpoint = "https://glados.ctisl.gtri.org/v1",
        model = "meta-llama/Llama-3.3-70B-Instruct",
        api_key_name = "GLADOS_API_KEY",
        disable_tools = true,
      },
    },
    hints = { enabled = false },
    mappings = {
      ask = prefix .. "<CR>",
      edit = prefix .. "e",
      refresh = prefix .. "r",
      focus = prefix .. "f",
      stop = prefix .. "S",
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
        add_all_buffers = prefix .. "B",
      },
      select_model = prefix .. "m",
      select_history = prefix .. "h",
    },
    windows = {
      width = 45,
    },
  },
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = { "yetone/avante.nvim" },
      specs = { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
      opts = {
        sources = {
          per_filetype = {
            AvanteInput = { "avante_commands", "avante_mentions", "avante_files" },
          },
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
