---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-Down>"] = false,
          ["<C-Left>"] = false,
          ["<C-Right>"] = false,
          ["<C-Up>"] = false,
          -- resize with arrows
          ["<Up>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
          ["<Down>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
          ["<Left>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
          ["<Right>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
        },
      },
    },
  },
  build = "./kitty/install-kittens.bash",
  opts = function(_, opts) opts.at_edge = require("smart-splits.types").AtEdgeBehavior.stop end,
}
