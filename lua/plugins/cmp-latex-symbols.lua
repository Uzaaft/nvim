return {
  "kdheepak/cmp-latex-symbols",
  lazy = true,
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = "kdheepak/cmp-latex-symbols",
      specs = { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
      opts = {
        sources = {
          default = { "latex" },
          providers = {
            latex = { name = "latex_symbols", module = "blink.compat.source", score_offset = -1 },
          },
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      optional = true,
      dependencies = "kdheepak/cmp-latex-symbols",
      opts = { sources = { { name = "latex_symbols", priority = 700 } } },
    },
  },
}
