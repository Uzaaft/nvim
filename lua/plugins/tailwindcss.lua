return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "js-everts/cmp-tailwind-colors", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)
          if item.kind == "Color" then return format_kinds(entry, item) end
          return item
        end
        return format_kinds(entry, item)
      end
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        names = true,
        tailwind = true,
      },
    },
  },
}
