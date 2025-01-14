return {
  "jc-doyle/cmp-pandoc-references",
  lazy = true,
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = "jc-doyle/cmp-pandoc-references",
      specs = { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
      opts = {
        sources = {
          default = { "pandoc" },
          providers = {
            pandoc = { name = "pandoc_references", module = "blink.compat.source", score_offset = 10 },
          },
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      optional = true,
      dependencies = "jc-doyle/cmp-pandoc-references",
      opts = { sources = { { name = "pandoc_references", priority = 725 } } },
    },
  },
}
