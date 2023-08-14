return {
  "danymat/neogen",
  cmd = "Neogen",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>a"] = { desc = "󰏫 Annotate" },
          ["<Leader>a<CR>"] = { function() require("neogen").generate() end, desc = "Current" },
          ["<Leader>ac"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
          ["<Leader>af"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
          ["<Leader>at"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
          ["<Leader>aF"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },
        },
      },
    },
  },
  opts = {
    snippet_engine = "luasnip",
    languages = {
      lua = { template = { annotation_convention = "emmylua" } },
      typescript = { template = { annotation_convention = "tsdoc" } },
      typescriptreact = { template = { annotation_convention = "tsdoc" } },
    },
  },
}
