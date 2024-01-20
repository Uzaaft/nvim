---@type LazySpec
return {
  "nvim-telescope/telescope-bibtex.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        extensions = {
          bibtex = { context = true, context_fallback = false },
        },
      },
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts) opts.mappings.n["<Leader>fB"] = { "<Cmd>Telescope bibtex<CR>", desc = "Find BibTeX" } end,
    },
  },
  init = function()
    require("astrocore").on_load("telescope.nvim", function() require("telescope").load_extension "bibtex" end)
  end,
}
