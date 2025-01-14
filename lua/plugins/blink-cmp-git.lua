return {
  "Kaiser-Yang/blink-cmp-git",
  lazy = true,
  dependencies = "nvim-lua/plenary.nvim",
  specs = {
    {
      "Saghen/blink.cmp",
      opts = {
        sources = {
          default = { "git" },
          providers = {
            git = {
              name = "Git",
              module = "blink-cmp-git",
              async = true,
              score_offset = 100,
              should_show_items = function(ctx)
                return vim.tbl_contains({ "gitcommit", "octo", "NeogitCommitMessage" }, vim.bo[ctx.bufnr].filetype)
              end,
            },
          },
        },
      },
    },
  },
}
