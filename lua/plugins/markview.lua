return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "markdown.mdx" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    hybrid_modes = { "n" },
    headings = { shift_width = 0 },
    code_blocks = { sign = false },
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].concealcursor = "c"
      end,
    },
  },
}
