local prefix = "<Leader>a"
---@type LazySpec
return {
  "danymat/neogen",
  cmd = "Neogen",
  opts = {
    snippet_engine = "luasnip",
    languages = {
      lua = { template = { annotation_convention = "emmylua" } },
      typescript = { template = { annotation_convention = "tsdoc" } },
      typescriptreact = { template = { annotation_convention = "tsdoc" } },
    },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { desc = "󰏫 Annotate" },
            [prefix .. "<CR>"] = { function() require("neogen").generate() end, desc = "Current" },
            [prefix .. "c"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
            [prefix .. "f"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
            [prefix .. "t"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
            [prefix .. "F"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },
          },
        },
      },
    },
  },
}
