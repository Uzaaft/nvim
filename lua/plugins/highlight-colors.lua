return {
  { "NvChad/nvim-colorizer.lua", enabled = false },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "User AstroFile", "InsertEnter" },
    cmd = "HighlightColors",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>uz"] = { function() vim.cmd.HighlightColors "Toggle" end, desc = "Toggle color highlight" }
        end,
      },
    },
    opts = { enable_named_colors = false, virtual_symbol = "" },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      if not opts.formatting then opts.formatting = {} end
      local formatter = vim.tbl_get(opts, "formatting", "format")
      opts.formatting.format = function(entry, item)
        local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
        if formatter then item = formatter(entry, item) end
        if color_item.abbr_hl_group then
          item.kind, item.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
        end
        return item
      end
    end,
  },
}
