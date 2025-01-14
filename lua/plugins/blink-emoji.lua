return {
  "moyiz/blink-emoji.nvim",
  lazy = true,
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          default = { "emoji" },
          providers = {
            emoji = { name = "Emoji", module = "blink-emoji", min_keyword_length = 1, score_offset = -1 },
          },
        },
      },
    },
  },
}
